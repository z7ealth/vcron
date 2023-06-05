module parsers

import types

pub fn parse_minutes(expression string, cron &types.Cron) &types.Cron {
	if field == "*" {
        return 1
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