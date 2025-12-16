import Link from 'next/link'

export default function Header(){
  return (
    <header className="bg-[var(--nn-surface)] border-b border-[#0B1A2B]">
      <div className="max-w-6xl mx-auto px-6 py-4 flex items-center justify-between">
        <Link href="/">
          <a className="flex items-center gap-3">
            <img src="/logo.svg" alt="NeuralNexus" className="w-10 h-10" />
            <span className="text-white font-semibold">NeuralNexus</span>
          </a>
        </Link>
        <nav className="flex gap-4 items-center">
          <Link href="/guilds"><a className="text-[var(--nn-muted)] hover:text-white">Guilds</a></Link>
          <Link href="/projects"><a className="text-[var(--nn-muted)] hover:text-white">Projects</a></Link>
          <Link href="/join"><a className="px-3 py-2 bg-[var(--nn-cyan)] text-black rounded-md">Join</a></Link>
        </nav>
      </div>
    </header>
  )
}