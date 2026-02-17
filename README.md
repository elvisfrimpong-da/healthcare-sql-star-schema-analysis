# HOSPITAL ICU & SICU Bed Capacity Analysis (SQL Project)

## Overview
This project evaluates Intensive Care Unit (ICU) and Surgical Intensive Care Unit (SICU) bed capacity across a hospital network to support a targeted nursing intervention pilot. The objective is to identify one or two hospitals with sufficient critical care scale, utilization, and staffing readiness to maximize clinical impact while maintaining cost effectiveness.

The analysis was conducted using SQL and a dimensional (star schema) data model to ensure clean aggregation and reliable reporting.

---

## Business Context
Research shows that higher nurse-to-patient ratios in critical care settings improve patient outcomes. Leadership requested an analysis to:

- Identify hospitals with ICU and/or SICU beds
- Rank hospitals by ICU/SICU capacity
- Narrow the selection to hospitals with both ICU and SICU units
- Recommend one or two pilot sites for implementation

The final recommendation is based on measurable bed capacity and operational readiness.

---

## Data Sources

### 1. `business`
Hospital-level information including:
- `ims_org_id` (Primary Key)
- `business_name`

### 2. `bed_type`
Bed classification information including:
- `bed_id` (Primary Key)
- `bed_code`
- `bed_desc`

### 3. `bed_fact`
Fact table containing measurable values at the grain of **hospital × bed type**:
- `license_beds`
- `census_beds`
- `staffed_beds`
- Foreign keys: `ims_org_id`, `bed_id`

---

## Data Model
A star schema was implemented to support efficient querying:

- **Fact Table:** `bed_fact`
- **Dimension Tables:** `business`, `bed_type`

The model ensures all bed measures are analyzed at the correct level of granularity, allowing ICU and SICU capacity to be isolated accurately.

See `/schema/star_schema.png` for the diagram.

---

## Analytical Approach

The analysis was performed in stages:

1. Identified hospitals with ICU (`bed_id = 4`) or SICU (`bed_id = 15`) beds
2. Ranked the top 10 hospitals by:
   - Licensed beds
   - Census beds
   - Staffed beds
3. Restricted results to hospitals with **both ICU and SICU capacity**
4. Compared performance across all three measures
5. Delivered an executive-level recommendation

SQL techniques used include:
- INNER JOIN
- GROUP BY
- ORDER BY
- SUM()
- HAVING with conditional logic
- LIMIT

---

## Key Findings

- High licensed capacity does not always translate to high utilization or staffing readiness
- A small subset of hospitals consistently ranks highly across all capacity measures
- Staffed beds are the most critical metric for assessing feasibility of a nursing expansion
- Hospitals appearing across licensed, census, and staffed rankings demonstrate both demand and operational strength

---

## Final Recommendation

Based on consistent performance across licensed, census, and staffed ICU/SICU beds, the recommended pilot hospitals are:

### University of Maryland Medical Center
- Highest licensed ICU/SICU capacity
- Highest staffed bed capacity
- Strong census volume
- Demonstrates operational scale and readiness

### Shands Hospital at the University of Florida
- Highest ICU/SICU census utilization
- Strong licensed and staffed support
- Balanced capacity and demand profile

These hospitals provide the strongest environment to evaluate the impact of an enhanced nurse-to-patient ratio in high-acuity care settings.

---

## Tools & Skills Demonstrated

- SQL (MySQL)
- Dimensional Modeling (Star Schema)
- Data Aggregation & Ranking
- Conditional Filtering (HAVING)
- Business-Oriented Insight Communication

---

## Repository Structure

