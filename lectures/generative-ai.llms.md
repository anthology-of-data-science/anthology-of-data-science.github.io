# Generative AI

Introduction to generative AI and agentic systems in a 4-hour lecture

Author

Daniel Kapitan

Published

December 5, 2024

# Introduction to Generative AI

From foundational models to GenAI systems and LLM agents

Daniel Kapitan [![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo1N0NEMjA4MDI1MjA2ODExOTk0QzkzNTEzRjZEQTg1NyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozM0NDOEJGNEZGNTcxMUUxODdBOEVCODg2RjdCQ0QwOSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozM0NDOEJGM0ZGNTcxMUUxODdBOEVCODg2RjdCQ0QwOSIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1IE1hY2ludG9zaCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkZDN0YxMTc0MDcyMDY4MTE5NUZFRDc5MUM2MUUwNEREIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjU3Q0QyMDgwMjUyMDY4MTE5OTRDOTM1MTNGNkRBODU3Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+84NovQAAAR1JREFUeNpiZEADy85ZJgCpeCB2QJM6AMQLo4yOL0AWZETSqACk1gOxAQN+cAGIA4EGPQBxmJA0nwdpjjQ8xqArmczw5tMHXAaALDgP1QMxAGqzAAPxQACqh4ER6uf5MBlkm0X4EGayMfMw/Pr7Bd2gRBZogMFBrv01hisv5jLsv9nLAPIOMnjy8RDDyYctyAbFM2EJbRQw+aAWw/LzVgx7b+cwCHKqMhjJFCBLOzAR6+lXX84xnHjYyqAo5IUizkRCwIENQQckGSDGY4TVgAPEaraQr2a4/24bSuoExcJCfAEJihXkWDj3ZAKy9EJGaEo8T0QSxkjSwORsCAuDQCD+QILmD1A9kECEZgxDaEZhICIzGcIyEyOl2RkgwAAhkmC+eAm0TAAAAABJRU5ErkJggg==)](https://orcid.org/0000-0001-8979-9194)

<d.kapitan@tue.nl>

Eindhoven AI Systems Institute

June 20, 2025

## Attribution

  

- Jakub M. Tomczak, [*Deep Generative Modeling, 2nd Edition*](https://jmtomczak.github.io/dgm_book.html) (2024)
- Jay Alammar & Maarten Grootendorst, [*Hands-On Large Language Models*](https://github.com/HandsOnLLM/Hands-On-Large-Language-Models) (2024)
- Maarten Grootendorst, [Visual Guide to LLM Agents](https://newsletter.maartengrootendorst.com/p/a-visual-guide-to-llm-agents) (2025)
- [Babak Esmaeli](https://babak0032.github.io/) provided the idea of Plato’s cave for explaining latent variables

# Generative Modeling

## The need for generative models

### Adding noise that humans can’t see, can trip the model badly

  

## The need for generative models

### We need better techniques for quantifying uncertainty

  

- Discriminative models only draw decision boundaries, generative reconstruct underlying distribution
- New data `X` lies far from bulk of training data, hence prediction is uncertain
  - Discriminitative model can’t ‘see’ this
  - Generative model will show that \\p(x)\\ is low

## The core rules of probability theory

  

### The product rule

\\ \begin{align} p(x, y) & = p(x\|y)p(y) \newline & = p(y\|x)p(x) \end{align} \\

*This is in fact Bayes’ rule written differently*

### The sum rule

\\ p(x) = \sum_y p(x, y)\\

## Overview of Generative AI

  

- Deep learning provides architecture for parameterizing the model
- Probabilistic modeling provides mathematical foundation for the model
- Software engineering provides computing resources for implementing the model

## Taxonomy of Deep Generative Modeling

  

- We will cover **Autoregressive Models ARM)** and **Latent Variable Models**
- *Quiz: which type of model won the Nobel Prize in Physics in 2024?*

# Autoregressive Models

## Remember time-series forecasting?

  

### In statistics, econometrics, and signal processing, **an autoregressive model**

- is a representation of a type of **random process**
- can be used to describe **time-varying** processes in nature, economics, behavior, etc.
- specifies that the **output variable depends** linearly on its **own previous values** and on a stochastic term

### [Markov property](https://en.wikipedia.org/wiki/Markov_property):

Stochastig process is memoryless, independent of its history:

\\ \begin{align} & P(\frac{\text{coding in Python is fun}}{\text{coding in Python is}}) \\ & \approx P(\frac{\text{Python is fun}}{\text{Python is}}) \end{align} \\

## Autoregressive models with neural networks

### Factorization of conditional probablities using product rule

  

- Say we have a variable \\\mathbf{x}\\ in \\D\\ dimensions and we want to model \\p(\mathbf{x})\\
- The conditional probablities can be written as: \\ p(\mathbf{x}) = p(x_1) \prod\_{d=2}^{D} p(x_d \| \mathbf{x}\_{\< d}) \\
- In case of three dimenions: \\ p(x1)p(x_2\|x_1)p(x_3\|x_1,x_2) \\

## Autoregressive models with neural networks

### Reduce complexity: finite memory

  

- to limit the complexity of a conditional model, assume a finite memory
- For instance, we can assume that each variable is dependent on no more than two other variables

\\ p(\mathbf{x}) = p(x_1) \prod\_{d=3}^{D} p(x_d \| x\_{d-1}, x\_{d-2}) \\

## Autoregressive models with neural networks

### Multilayer perceptron (MLP) depending on two last inputs

## Autoregressive models with neural networks

### Long Short-Term Memory (LSTM) Recurrent Neural Networks

  

- We want to have more long term memory, but still want to minimize the model’s complexity
- LSTM RNN is a possible solution to this:

\\ p(\mathbf{x}) = p(x_1) \prod\_{d=3}^{D} p(x_d \| RNN(x\_{d-1}, h\_{d-1})) \\

## Autoregressive models with neural networks

### Recurrent Neural Network (RNN) depending on two last inputs

## Autogressive models with neural networks

### Discriminative vs. generative LSTM RNN ([Yogamata et. al (2017)](https://arxiv.org/pdf/1703.01898))

Use-case: text classification

- Predict document class \\y\\ for each sequence of words \\x_1, x_2, ...\\
- Inputs are static embeddings of words
- All outputs are combined into output, typically softmax activation function

Use-case: next token prediction

- Same as before, but we add class embeddings \\\mathbf{V}\\
- Note use of chain rule to calculate conditional probabilities for each word
- Recursively use output of \\x\_{t-1}\\ as input for \\x_t\\s

## The Transformer

### Attention is all you need (source: [Jay Alammar](https://jalammar.github.io/illustrated-transformer/))

  

## The Transformer

### Attention is all you need (source: [Jay Alammar](https://jalammar.github.io/illustrated-transformer/))

- Concept of **Query**, **Key** and **Values** is analogous to information retrieval in a database
- Computation is ‘just’ matrix multiplication
  - Can be run in parallel (multiple attention heads)
  - Optimized software for matrix computations
  - still, this is computationally the most expensive parts
- Ongoing developments
  - More efficient attention calculation
  - Alternative architectures: XLSTM, state space models (SSM)

## The Transformer

### Example sequence-to-sequence: translation (source: [Jay Alamar](https://jalammar.github.io/illustrated-transformer/))

# Latent Variable Models

## 

Back to the main problem, how can the bounded observer learn a representation that is faithful to the object? There are multiple ways to approach this, but the one approach I want to focus on is through generative modeling. 

## 

Back to the main problem, how can the bounded observer learn a representation that is faithful to the object? There are multiple ways to approach this, but the one approach I want to focus on is through generative modeling. 

## 

Let’s extend this setting in the following way. Before being shown the shadow of this dove, the observer was shown a variety of different casted shadows for different objects and from different angles.  In the generative modeling approach, the bounded observer first has to understand the process of how the light projects a shadow when it shines through an object. That is to say, the bounded observer first has to think about and understand what is mapping from the object to the shadow.

## 

To model this in a probabilistic way, the observer has to think of two things.

First, what is distribution over objects and their properties? So what do we believe about the types of objects that this other guy behind the wall has with him? It could be doves, cats, dogs, maybe doves of different breeds. We call distribution a prior. 

## 

Second, given an object, what is the distribution over possible casted shadows? We call this distribution the likelihood model.  Now of course in this example, we exactly know the physics behind the relationship between lights and shadows, but in general, this generative process is unknown to the observer and they have to learn this model. And note that this process also can be noisy.

## 

Once the observer has learned this model, they can go back to the original task which is given this shadow, what is the distribution over possible objects that could have casted this shadow? We can call this distribution the inference model and the reason we can call this inference model is that the observer has to infer this model by trying to reverse engineer the generative model described before.  

## 

VAEs roughly describes the learning process of this observer. In a VAE, we have a generative model that consists of a representation space that corresponds to the space of objects, or at least some abstract idea of an object, and a mapping from this space to the projection space and vice versa.

We can jointly optimize these two models such that 1. the marginal distribution of our model over the shadows explains the shadows they have seen so far. 2. The inference distribution is exactly the inverse of the likelihood model.

## The Autoencoder

## The Variational Autoencoder (VAE)

## The Variational Autoencoder (VAE)

# Generative AI Systems

## From models to systems

  

## Intermezzo: getting the terminology right

### Embeddings, encoders, decoders …

  

- **Embeddings**: usually static [embedding](https://en.wikipedia.org/wiki/Word_embedding) like word2vec, always needed to transform text into vectors with *some* context information
- **Encoder**: a contextual embedding like BERT, often referred to as encoder-only transformer
- **Decoder**: often the core of the generative AI system, with the decoder-only transformers (generative pre-trained transformer, GPT) as a well-known example

## Retrieval Augmented Generation

### Source: [Meta blogpost (2020)](https://ai.meta.com/blog/retrieval-augmented-generation-streamlining-the-creation-of-intelligent-natural-language-processing-models/)

# An error occurred.

Unable to execute JavaScript.

## ImaGen: Diffusion + Superresolution

### Source: [Google DeepMind](https://papers.nips.cc/paper_files/paper/2022/hash/ec795aeadae0b7d230fa35cbaf04c041-Abstract-Conference.html)

## ImaGen: Diffusion + Superresolution

### Source: [Google DeepMind](https://papers.nips.cc/paper_files/paper/2022/hash/ec795aeadae0b7d230fa35cbaf04c041-Abstract-Conference.html)

# LLM Agents

## What is an agent?

An agent is anything that can be viewed as perceiving its environment through sensors and acting upon that environment through actuators.

— Russell & Norvig, AI: A Modern Approach (2016)

## The “augmented LLM” as an agent

*Note people disagree with calling current state-of-the art agentic AI. You can decide yourself after the hands-on session.*

  

## Why do we need augmentation?

## The autonomy of your LLM agent depends on its design

## The need for short-term memory

## The need for long-term memory

## Adding short and long-term memory

- Short term memory: just use context window, possibly with summary of previous input
- Long term memory: vector database

## Long-term memory with vector database

## Using tools with LLMs

## Different between procedural programming and agents

  

## Different between procedural programming and agents

  

## Model Context Protocol

  

## Model Context Protocol

  

## Reasoning with Chain-of-Thought

## Reasoning and Acting

  

## Adding reflection

## From single to multi-agents

## From single to multi-agents

  

## Modular multi-agents frameworks

## Isabella: simulacra or simulation?

  

- Simulacra are copies that depict things that either had no original, or that no longer have an original.
- Simulation is the imitation of the operation of a real-world process or system over time.

## Simulacra or simulation?

## Simulacra or simulation?

  

## Frameworks in Python for building agentic AI apps

- [CrewAI](https://docs.crewai.com/): a lean Python framework built entirely from scratch—completely independent of LangChain or other agent frameworks.
- [Pydantic AI](https://ai.pydantic.dev/): a Python agent framework designed to make it less painful to build production grade applications with Generative AI. Plays nicely with the pydantic validation library.
- [AutoGen](https://microsoft.github.io/autogen/stable//index.html): Microsoft’s open-source programming framework for agentic AI
- [Langgraph](https://langchain-ai.github.io/langgraph/): part of the LangChain stack
- [type-ai/fenic](https://docs.fenic.ai/latest/): new kid on the block, backed by Wes McKinney s

# Examples from Texterous

## Scraping job postings

## Document retrieval: finding relevant grants

## Education: lesson plan generator

## Education: lesson plan generator

# AlphaFold: predicting 3D structure of proteins

## AlphaFold 2 in a nutshell

# An error occurred.

Unable to execute JavaScript.

## AlphaFold 2 architecture

## AlphaFold 3: prediction of nearly all molecular types in the Protein Data Bank

- a, The pairformer module. Input and output: pair representation with dimension (n, n, c) and single representation with dimension (n, c). n is the number of tokens (polymer residues and atoms); c is the number of channels (128 for the pair representation, 384 for the single representation). Each of the 48 blocks has an independent set of trainable parameters.
- b, The diffusion module. Input: coarse arrays depict per-token representations (green, inputs; blue, pair; red, single). Fine arrays depict per-atom representations. The coloured balls represent physical atom coordinates. Cond., conditioning; rand. rot. trans., random rotation and translation; seq., sequence.
- c, The training set-up (distogram head omitted) starting from the end of the network trunk. The coloured arrays show activations from the network trunk (green, inputs; blue, pair; red, single). The blue arrows show abstract activation arrays. The yellow arrows show ground-truth data. The green arrows show predicted data. The stop sign represents stopping of the gradient. Both depicted diffusion modules share weights.
- d, Training curves for initial training and fine-tuning stages, showing the LDDT on our evaluation set as a function of optimizer steps. The scatter plot shows the raw datapoints and the lines show the smoothed performance using a median filter with a kernel width of nine datapoints. The crosses mark the point at which the smoothed performance reaches 97% of its initial training maximum.

## Thanks for your attention.

![](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAlgAAAB7CAYAAACowf5tAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAhGVYSWZNTQAqAAAACAAFARIAAwAAAAEAAQAAARoABQAAAAEAAABKARsABQAAAAEAAABSASgAAwAAAAEAAgAAh2kABAAAAAEAAABaAAAAAAAAASwAAAABAAABLAAAAAEAA6ABAAMAAAABAAEAAKACAAQAAAABAAACWKADAAQAAAABAAAAewAAAADx7GtvAAAACXBIWXMAAC4jAAAuIwF4pT92AAACzGlUWHRYTUw6Y29tLmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iWE1QIENvcmUgNi4wLjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczp0aWZmPSJodHRwOi8vbnMuYWRvYmUuY29tL3RpZmYvMS4wLyIKICAgICAgICAgICAgeG1sbnM6ZXhpZj0iaHR0cDovL25zLmFkb2JlLmNvbS9leGlmLzEuMC8iPgogICAgICAgICA8dGlmZjpZUmVzb2x1dGlvbj4zMDA8L3RpZmY6WVJlc29sdXRpb24+CiAgICAgICAgIDx0aWZmOlJlc29sdXRpb25Vbml0PjI8L3RpZmY6UmVzb2x1dGlvblVuaXQ+CiAgICAgICAgIDx0aWZmOlhSZXNvbHV0aW9uPjMwMDwvdGlmZjpYUmVzb2x1dGlvbj4KICAgICAgICAgPHRpZmY6T3JpZW50YXRpb24+MTwvdGlmZjpPcmllbnRhdGlvbj4KICAgICAgICAgPGV4aWY6UGl4ZWxYRGltZW5zaW9uPjYwMDwvZXhpZjpQaXhlbFhEaW1lbnNpb24+CiAgICAgICAgIDxleGlmOkNvbG9yU3BhY2U+MTwvZXhpZjpDb2xvclNwYWNlPgogICAgICAgICA8ZXhpZjpQaXhlbFlEaW1lbnNpb24+MTIzPC9leGlmOlBpeGVsWURpbWVuc2lvbj4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94OnhtcG1ldGE+CrU1D68AADcfSURBVHgB7Z0H2OxE1cej0qR8dEQEkY6A9HaRKigISlMsVEWkg/SqSBPpVZp0vAiKBREQUBAEvCBdBK5UEQRBxUJTvLrf/PIw6+xsysxusvV/nud9d5NMzsz8k03OnPq2JEmeMn8LmD+REBACQkAI9AeBxuTJk/+x2GKLzWi6f0d/hqBehYAQqBKBt1fJTLyEgBAQAkJACAgBISAEkkQClu4CISAEhIAQEAJCQAhUjIAErIoBFTshIASEgBAQAkJACEjA0j0gBISAEBACQkAICIGKEZCAVTGgYicEhIAQEAJCQAgIAQlYugeEgBAQAkJACAgBIVAxAhKwKgZU7ISAEBACQkAICAEhIAFL94AQEAJCQAgIASEgBCpGQAJWxYCKnRAQAkJACAgBISAEJGDpHhACQkAICAEhIASEQMUISMCqGFCxEwJCQAgIASEgBISABCzdA0JACAgBISAEhIAQqBgBCVgVAyp2QkAICAEhIASEgBCQgKV7QAgIASEgBISAEBACFSMgAatiQMVOCAgBISAEhIAQEAISsHQPCAEhIASEgBAQAkKgYgQkYFUMqNgJASEgBISAEBACQkAClu4BISAEhIAQEAJCQAhUjIAErIoBFTshIASEgBAQAkJACEwlCISAEBACQkAICAEhEIPAvffemzQajeRtb3tb7mkc52/ZZZdNpp566tx2o3pAAtaoXlnNSwgIASEgBIRADQhcc801ycc//vEgzu95z3uShx56KJl11lmD2o9SI5kIR+lqai5CQAgIASEgBGpG4Hvf+15wD5/73OfGUrgCIAlYwbeJGgoBISAEhIAQGG8EHn300eSSSy4JBmHzzTcPbjtqDWUiHLUrWsN8PvCBD6Q2dD7nm2++ZI455khmmmmm1KY+ZcqU5PXXX09eeuml5LnnnkseeOCB5Fe/+lXy29/+toaRiGW/EVhttdWSeeedN5l++umTv/zlL8kzzzyT/PrXv+73sNS/EBACPULghz/8YXBPCFfLL798cPtRa1i5gHXooYcmK664YvLf//63p1jR3w9+8IPk8ssvr7Tf//u//0uOO+645L3vfW/pnN58883ksssuS8dR6SAMsw9/+MPJjjvumEw33XSlrBF4TjvttOSXv/xladu8BksvvXTy6U9/OvnQhz6UrLDCClEOiv/617+Se+65J7n55puTq6++Ov2e10/Wfua50UYbJW9/e7GCleMvvPBCcuSRRya///3vs1hl7vvWt76VrLXWWoXXE973339/ss022yT/+Mc/EvA4/fTTkwUXXDDliTC51157pcIkO44++uhkq622Sh0+cfp85ZVX0vuGvlzigfPVr341mWWWWdK2P/vZz5Ltt9++2eRHP/pRstxyy7WMDSfRf//738nf/va3VKDBuZSHXJ4Q+7WvfS3ZcsstU/6cy2rz8MMPb/bBl3e+853JVVddlbz//e9PnVD//Oc/J3vssUfmPYNgvcsuuyTrr79+c/6WGb87xsNv79hjj7W70093ruwAk2OOOSb59re/3dKOjU022SS9juACgfkhhxySvPzyy8nJJ5+czD333Ok404MZ/5gnWB922GHp0d133z3Ze++9k3e84x3pNr/NM888M/1duKdzH/D7fve7353ixTVnLKNCf/jDHxJ+j6NEXGuex3lO0wj+PAOLnK+L8GAB0Qt68cUXE+7L2HEy/6mmmiq9Z3sxTrePf/7zn8kVV1zh7ir8vsUWWxQeH4eDT5lJNqr6+81vfmOuf3/o7LPPrmweFg/zEo2azE033VT5GBjL/vvvHzWOnXbaqaNxLLPMMo2LLrqoYR5QUf3lNTYPkMb3v//9xkc/+tHg8XznO9/JY5e5f+211w7mDZZPPPFEJh9/p3m5N8yDPOX9kY98xD/cME6ezX6NYNR2/JFHHmket/eTEWJa2vF7scf4NEJUy/G8DSOANE455ZSWcy2fa6+9tuU08LfH7CfzMkJbSzsjELW123XXXRt/+tOfWtrlbRiBvvHBD36wyWPllVdu/Oc//2lpfuWVVzaP27HweeGFF7a0Y2zci5/61Kda9hdtGKGzydssMNqamhdaY7HFFmu2oV+fP/i74+rh9/9OnjyZiz+lbeBd7FhnnXX6NZ9a+/XvFxcis7joqm8joLnsavtuFs0dj9MsehqvvfZabWPLY5z1LMn7jfBbM4uqPFZjsb9YRWCQGyayq9Uqx2wewFHs0PigbRpGQvt46623JjglouGoglhlosm47rrrUg3DIossUgXbnvAo06CVDQLt0Ekn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)

<https://anthology-of-data.science>

(view [full screen](https://anthology-of-data.science/lecture-generative-ai/#/title-slide))
