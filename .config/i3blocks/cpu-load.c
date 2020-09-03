#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>

#define DELAY     2 // delay between usage parses
#define PERCISION 2 // floating point percision
#define ull unsigned long long int

ull parse_usage(int *nonidled) {
  FILE *fp = fopen("/proc/stat", "r");
  if (!fp)
    exit(EXIT_FAILURE);

  ull usr, nice, sys, idle, iowait, irq, softirq, steal, gst, gst_nice;
  if (!fscanf(fp, "cpu  %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu",
         &usr, &nice, &sys, &idle, &iowait, &irq, &softirq, &steal, &gst,
         &gst_nice)) 
    fclose(fp);
    exit(EXIT_FAILURE);
  *nonidled = usr + nice + sys + irq + softirq + steal;
  fclose(fp);
  return *nonidled + idle + iowait;
}

int main() {
  int prev_nonidled, nonidled;
  ull prev_total, total;
  prev_total = parse_usage(&prev_nonidled);
  sleep(DELAY);

  total = parse_usage(&nonidled) - prev_total;
  printf("%.*lf%%\n", PERCISION, 100.0D * (nonidled-prev_nonidled) / total);

  return 0;
}
