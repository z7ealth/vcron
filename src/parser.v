module vcron

// Parses the crontab expression
fn parse_crontab(entry string) string {
    mut fields := entry.split(' ')
    if fields.len != 5 {
        return "Invalid crontab entry"
    }
    
    mut minute := fields[0]
    mut hour := fields[1]
    mut day_of_month := fields[2]
    mut month := fields[3]
    mut day_of_week := fields[4]
    
    minute = parse_field(minute, 0, 59)
    hour = parse_field(hour, 0, 23)
    day_of_month = parse_field(day_of_month, 1, 31)
    month = parse_field(month, 1, 12)
    day_of_week = parse_field(day_of_week, 0, 7)
    
    return "Minute: $minute, Hour: $hour, Day of Month: $day_of_month, Month: $month, Day of Week: $day_of_week"
}

fn parse_field(field string, min int, max int) string {
    if field == "*" {
        return "*"
    }
    
    if field.contains(',') {
        mut parts := field.split(',')
        mut parsed_parts := []string{}
        for part in parts {
            mut parsed_part := parse_field(part, min, max)
            if parsed_part == "Invalid field" {
                return "Invalid field"
            }
            parsed_parts << parsed_part
        }
        return parsed_parts.join(',')
    }
    
    if field.contains('-') {
        mut range := field.split('-')
        if range.len != 2 {
            return "Invalid field"
        }
        
        mut start := range[0].int()
        mut end := range[1].int()
        
        if start == 0 && end == 0 {
            return "Invalid field"
        }
        
        if start < min || end > max {
            return "Invalid field"
        }
        
        return "$start-$end"
    }
    
    mut value := field.int()
    if value < min || value > max {
        return "Invalid field"
    }
    
    return field
}