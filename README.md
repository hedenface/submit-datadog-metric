# submit-datadog-metric

Submit a generic metric to DataDog

## How Do

```sh
./submit-metric.sh -m <metric name> -v <metric value> -T <metric type> -t <ts> [tag1:value1] [tag2:value2]
```

## Meet The Arguments

* `-h` help
	print usage and exit
* `-m` metric name
	**REQUIRED**
* `-v` metric value
	**REQUIRED**
* `-T` metric type
	optional, default `0`
* `-t` timestamp
	optional, default: now
* tags
	optional (but encouraged)
	format should be `tag:value`
