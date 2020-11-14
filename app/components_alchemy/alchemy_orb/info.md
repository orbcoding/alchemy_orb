Keeping alchemy components separate with AlchemySubspace:: namespaces to avoid polluting Alchemy:: namespace or conflicts with application components. Separation also simplifies application pack components/** glob imports.

Expected folders:
- alchemy_admin (included in admin packs)
- alchemy_element (rest included in application)
- alchemy_page
- alchemy_render
