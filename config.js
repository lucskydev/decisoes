// Configuração do Supabase.
// A chave "anon" é pública por design: quem protege seus dados são as regras (RLS)
// criadas pelo supabase-setup.sql e o login. NUNCA coloque aqui a chave "service_role".
window.APP_CONFIG = {
  SUPABASE_URL: 'https://COLE_O_ID_DO_PROJETO.supabase.co',
  SUPABASE_ANON_KEY: 'COLE_A_CHAVE_ANON_AQUI'
};
