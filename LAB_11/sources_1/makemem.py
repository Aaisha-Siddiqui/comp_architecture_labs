words = [line.strip().replace("0x", "") for line in open("words.txt") if line.strip()]
with open("fsm_program.mem", "w") as f:
    for w in words:
        w = w.zfill(8)
        b = [w[6:8], w[4:6], w[2:4], w[0:2]]
        f.write("\n".join([]) if False else " ".join(b).upper() + "\n")
