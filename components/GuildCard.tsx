type Props = { title: string, tag?: string }
export default function GuildCard({ title, tag }: Props){
  return (
    <article className="p-6 rounded-xl bg-[linear-gradient(0deg,rgba(255,255,255,0.02),rgba(255,255,255,0.02))] border border-[#102030]">
      <h3 className="text-xl text-white font-semibold">{title}</h3>
      <p className="text-[var(--nn-muted)] mt-2">{tag}</p>
      <div className="mt-4">
        <a className="inline-block px-3 py-2 rounded-md text-sm bg-[var(--nn-purple)]" href={`/guilds`}>Explore</a>
      </div>
    </article>
  )
}