# metashot/containment

metashot/containment is a workflow for the containment estimation of genomes,
proteomes, plasmids and other sequences in sequencing read sets using [mash
screen](https://mash.readthedocs.io/).

- [MetaShot Home](https://metashot.github.io/)

## Main features

- Input: single-end, paired-end sequences in FASTA/FASTQ formats (gzip
  compressed files also supported);
- genomes or sequences on which test the containment in FASTA or mash sketch
  formats;
- returns the multeplicity matrix (genomes x read sets).


## Quick start (examples)
Install Docker (or Singulariry) and Nextflow (see
[Dependencies](https://metashot.github.io/#dependencies)); 

### Example 1 - genomes containment in single-end or interleaved read sets

```bash
nextflow run metashot/containment \
  --reads 'reads/*.fastq.gz' \
  --db 'genomes/*.fa' \
  --outdir results
```

### Example 2 - genomes containment in paired-end read sets

```bash
nextflow run metashot/containment \
  --reads 'reads/*_R{1,2}*.fastq.gz' \
  --db 'genomes/*.fa' \
  --outdir results
```

### Example 3 - sequences containment in paired-end read sets

```bash
nextflow run metashot/containment \
  --reads 'reads/*_R{1,2}*.fastq.gz' \
  --db sequences.fa \
  --individual \
  --outdir results
```

## Parameters
Options and default values are decladed in [`nextflow.config`](nextflow.config).

## System requirements
Please refer to [System
requirements](https://metashot.github.io/#system-requirements) for the complete
list of system requirements options.
