# 🥪 The Jaffle Shop 🦘

_powered by the dbt Fusion engine_

Welcome! This is a sandbox project for exploring the basic functionality of Fusion. It's based on a fictional restaurant called the Jaffle Shop that serves [jaffles](https://en.wikipedia.org/wiki/Pie_iron).

To get started:
1. Set up your database connection in `~/.dbt/profiles.yml`. If you got here by running `dbt init`, you should already be good to go.
2. Run `dbt build`. That's it!

> [!NOTE]
> If you're brand-new to dbt, we recommend starting with the [dbt Learn](https://learn.getdbt.com/) platform. It's a free, interactive way to learn dbt, and it's a great way to get started if you're new to the tool.

## Semantic Layer

This project includes a **dbt Semantic Layer** configuration for consistent metrics across Tableau tools:

- **Semantic Models**: Defined in `models/tableau/semantic_models.yml`
- **Metrics**: Defined in `models/tableau/metrics.yml`
- **Tableau Integration**: See [TABLEAU_SEMANTIC_LAYER_GUIDE.md](TABLEAU_SEMANTIC_LAYER_GUIDE.md) for connection instructions

Available metrics include: total revenue, total profit, profit margin, order count, customer lifetime value, and more.