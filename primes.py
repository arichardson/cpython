def get_primes(n):
	numbers = set(range(n, 1, -1))
	primes = []
	while numbers:
		p = numbers.pop()
		primes.append(p)
		numbers.difference_update(set(range(p * 2, n + 1, p)))
	return primes

primes = get_primes(100000)
print("last prime:", primes[len(primes) - 1])

