module vcron

// Schedules a job by passing a crontab expression
pub fn schedule(crontab string) string {
	return parse_crontab(crontab)
}