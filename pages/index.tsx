import Head from 'next/head'
import Header from '../components/Header'
import GuildCard from '../components/GuildCard'

export default function Home() {
  return (
    <>
      <Head>
        <title>NeuralNexus — Collective intelligence for builders</title>
        <meta name="description" content="Connected minds build better futures. Join NeuralNexus." />
      </Head>
      <Header />
      <main className="max-w-6xl mx-auto px-6 py-12">
        <section className="text-center mb-12">
          <h1 className="text-4xl md:text-5xl font-extrabold text-white mb-4">NeuralNexus</h1>
          <p className="text-lg md:text-xl text-[var(--nn-muted)] max-w-2xl mx-auto">
            Connected minds build better futures. A symbiotic ecosystem for technologists to unite, elevate, and create.
          </p>
          <div className="mt-8 flex justify-center gap-4">
            <a className="px-6 py-3 rounded-lg bg-[var(--nn-cyan)] text-black font-semibold" href="/join">Join the Founding Circle</a>
            <a className="px-6 py-3 rounded-lg border border-[var(--nn-muted)]" href="/guilds">Explore Guilds</a>
          </div>
        </section>

        <section>
          <h2 className="text-2xl text-white mb-6">Guilds</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            <GuildCard title="Web Nexus" tag="React • Node • Design" />
            <GuildCard title="Android Nexus" tag="Kotlin • Flutter • UX" />
            <GuildCard title="Data Nexus" tag="ML • BI • Dashboards" />
            <GuildCard title="DevOps Nexus" tag="IaC • CI/CD • Security" />
          </div>
        </section>
      </main>
    </>
  )
}