module vcron

fn test_vcron() {
	result := schedule("0 8 * * *")
	println(result)
}