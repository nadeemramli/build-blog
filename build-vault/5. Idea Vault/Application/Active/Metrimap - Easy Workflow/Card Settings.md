---
draft: true
title: "Card Settings"
date: "2025-08-01"
tags: 
---
const sourceTypeOptions: Array<{ value: SourceType; label: string }> = [

  { value: "Manual", label: "Manual Entry" },

  { value: "Calculated", label: "Calculated Formula" },

  { value: "Random", label: "Random Data (Testing)" },

];

  

const dimensionOptions: Array<{ value: Dimension; label: string }> = [

  { value: "Qualitative", label: "Qualitative" },

  { value: "Quantitative", label: "Quantitative" },

  { value: "Vanity", label: "Vanity" },

  { value: "Actionable", label: "Actionable" },

  { value: "Efficiency", label: "Efficiency" },

  { value: "Effectiveness", label: "Effectiveness" },

  { value: "Strategic", label: "Strategic" },

  { value: "Tactical", label: "Tactical" },

  { value: "Operational", label: "Operational" },

];

  

const causalFactorOptions: Array<{ value: CausalFactor; label: string }> = [

  { value: "Component Drift", label: "Component Drift" },

  { value: "Temporal Variance", label: "Temporal Variance" },

  { value: "Influence Drift", label: "Influence Drift" },

  { value: "Dimension Drift", label: "Dimension Drift" },

  { value: "Event Shocks", label: "Event Shocks" },

];


const categoryOptions: Array<{ value: CardCategory; label: string }> = [

  { value: "Core/Value", label: "Core/Value" },

  { value: "Data/Metric", label: "Data/Metric" },

  { value: "Work/Action", label: "Work/Action" },

  { value: "Ideas/Hypothesis", label: "Ideas/Hypothesis" },

  { value: "Metadata", label: "Metadata" },

];

  

const subCategoryOptions: Record<

  CardCategory,

  Array<{ value: string; label: string }>

> = {

  "Core/Value": [

    { value: "Journey Step", label: "Journey Step" },

    { value: "Value Chain", label: "Value Chain" },

    { value: "Critical Path", label: "Critical Path" },

  ],

  "Data/Metric": [

    { value: "Input Metric", label: "Input Metric" },

    { value: "Output Metric", label: "Output Metric" },

    { value: "Leading KPI", label: "Leading KPI" },

    { value: "Lagging KPI", label: "Lagging KPI" },

    { value: "Diagnostic Metric", label: "Diagnostic Metric" },

    { value: "North Star Metric", label: "North Star Metric" },

  ],

  "Work/Action": [

    { value: "Experiment", label: "Experiment" },

    { value: "BAU", label: "BAU (Business as Usual)" },

    { value: "Initiative", label: "Initiative" },

    { value: "Scope/Function", label: "Scope/Function" },

    { value: "Business Driver", label: "Business Driver" },

  ],

  "Ideas/Hypothesis": [

    { value: "Factor", label: "Factor" },

    { value: "Seller Solution", label: "Seller Solution" },

  ],

  Metadata: [

    { value: "Group", label: "Group" },

    { value: "Subflow", label: "Subflow" },

    { value: "Reference", label: "Reference" },

  ],

};




utils libs for card settings

- types for causal factor etc