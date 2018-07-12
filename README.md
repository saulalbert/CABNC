# CABNC transcription project

## Outline

The CABNC corpus is a open-licensed, detailed conversation analytic
re-transcription of naturalistic conversations from a subcorpus of the [British
National Corpus](http://www.natcorp.ox.ac.uk/) amounting to around 4.2 million
words in 1436 separate conversations.

The project aims to produce transcripts usable for both computational and
detailed qualitative analysis. If you are a CA transcriptionist and you use the
data, please make sure you re-submit your updated transcripts to help improve
the corpus over time.

## Accessing and using CABNC data

### Using transcripts

* You can browse and listen to the latest versions of individual CABNC transcripts as [CHAT-CA files on TalkBank](https://ca.talkbank.org/browser/index.php?url=CABNC/), and the latest stable release of CABNC can be [downloaded as an archive from TalkBank](https://ca.talkbank.org/access/CABNC.html).
* The corresponding audio files for each transcript can be downloaded from the [Audio BNC project’s list of urls](http://bnc.phon.ox.ac.uk/filelist-wav.txt).

To edit transcripts in [CLAN](http://childes.psy.cmu.edu/clan/), place both the
transcript .cha file and the audio .wav file in the same directory. Check the
[CLAN manual](http://childes.psy.cmu.edu/manuals/CLAN.pdf) for details of how
to use the CLAN editor.

### Contributing transcripts

Transcriptions are made using [Jeffersonian CA transcription
conventions](http://homepages.lboro.ac.uk/~ssca1/notation.htm), and the CHAT-CA
file format and transcription symbols provided by the
[CLAN](http://childes.psy.cmu.edu/clan/) transcription system.

A [guideline for transcribers is currently being
devised](https://github.com/saulalbert/CABNC/wiki/CHAT-CA-lite) to help with
standardisation - the guidelines adhere as closely as possible to current
standards in CA without sacrificing machine readability.

To use or contribute to these transcripts:

1. download and install [CLAN](http://childes.psy.cmu.edu/clan/),
2. download the [corresponding audio file](http://bnc.phon.ox.ac.uk/filelist-wav.txt) from the [Audio BNC site](http://www.phon.ox.ac.uk/AudioBNC#Access),
3. improve existing transcripts with CLAN, then submit them to the CABNC project for inclusion.

## Underlying BNC Data and Usage Rights

### Accessing original BNC data

The data on which this project builds is available here:

* The original [Audio BNC transcripts are available in HTML format](http://bnc.phon.ox.ac.uk/transcripts-html/) via the AudioBNC 
* Audio data and Praat TextGrid are available on the Oxford Phonetics Institute [AudioBNC site](http://www.phon.ox.ac.uk/AudioBNC#Access).

If you want to perform complex searches on BNC data:

* Lancaster University's [BNCweb tool](http://bncweb.lancs.ac.uk/): provides a useful web interface for searching the BNC and checking the audio location of sections of transcript.

### Subcorpus Data Selection Rationale

[The Audio BNC](http://www.natcorp.ox.ac.uk/) contains about 7.5 million words of recorded speech, all of
it already roughly transcribed, with audio recordings of sufficient quality for
automated phonetic transcriptions, and full Praat TextGrid files aligning audio
to transcriptions are available for the entire corpus. There are also
comprehensive wordclass and part-of-speech tag annotations. Within the overall
BNC corpus, this project focuses on a subcorpus of more naturalistic,
conversations from informal contexts. These include 152 rough transcripts of
audio files, labelled by the original BNC transcribers with the following tags:

* Overall category: Demographically sampled (subjects carrying audio recorders around)
* Interaction type: Dialogue (rather than speeches/monologues)
* Genre type: conv. (conversation).

These are conversations around water-coolers, in corridors, bus-stops, homes
etc. and as such are most useful for analysing natural talk-in-interaction.
There are 4,228,314 words in this subcorpus. 

## Rights and Usage Information

* All files are publicly available under a Creative Commons Attribution License ([details here](http://creativecommons.org/licenses/by/3.0/))
* Please cite use of these transcriptions as: Saul Albert, Laura E. de Ruiter, and  J.P. de Ruiter (2015) CABNC: the Jeffersonian transcription of the Spoken British National Corpus. [https://saulalbert.github.io/CABNC/](https://saulalbert.github.io/CABNC/).
* BNC spoken audio recordings were created or collected from other sources by Longman Dictionaries for the British National Corpus Consortium. Their usage is governed by the [terms of the original recording permissions agreement](http://www.natcorp.ox.ac.uk/corpus/permletters.html#spoken1) with the contributors, which requires that they can only be "used for scientific study and publication by writers of dictionaries and educational material and language researchers". 
* Please cite use of the AudioBNC recordings and associated transcription/annotations as: John Coleman, Ladan Baghai-Ravary, John Pybus, and Sergio Grau (2012) Audio BNC: the audio edition of the Spoken British National Corpus. Phonetics Laboratory, University of Oxford. [http://www.phon.ox.ac.uk/AudioBNC](http://www.phon.ox.ac.uk/AudioBNC).
* Many thanks to [Dr. Margaret E. L. Renwick](http://linguistics.uga.edu/directory/people/margaret-e-l-renwick) for her forced alignment data, which we used to enrich the BNC-XML with word and turn-timing data.</li>
* We are very grateful to [Prof. Brian MacWhinney](https://www.cmu.edu/dietrich/psychology/people/core-training-faculty/macwhinney-brian.html) for his tireless support helping us prepare these data for [TalkBank](https://talkbank.org/access/CABank/CABNC.html).
