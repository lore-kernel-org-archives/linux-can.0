Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794230194;
	b=zO6thbHfckOo0Fl+8L/K3washekqlTGVW7wFC6lkdX8AiIH5ehE3g87Nbljp200vO5M7
	 O5GDc5JadUVdM/bLTNXrbb9CXb6cIrsfK4BaD6/t19oVpoORnxnGsGAH0O7byacq44mY+
	 OKcjcrcLK6skA01ERr7ianpQiLvQBy2FUeqeCMIhLIlDeSpRm2m0BSktGduYGJPP42ZgQ
	 OZI2CzcQC8iOCaIpVXhJC649917FS8EWYvrayXSsUX0GhoJctTiA5ndfw4w9tgMljuB0H
	 31Y73Qlr5/Q/PqUtRy8rbf8Pm+gXi2JR9JsGbqUlga2rtLKgkf/qdAJjm7nmIyZc8zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794230194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ssSp4uhg2na5mlS8fgRxXLVgT3tscKVQqq7yr3h9PBo=;
	b=306iePy7F4X1r0ETSJgg9Sj2mOv1YNISGOIP+5+LBUYuDXtSJLiLlrIzPjPW4lTA3M2n
	 DLhusVqy30b/NkoRTNw+PWFXxstGbHL419+reVi1pLPbu/Ew7FMjGEI26Z5YyFcD00T86
	 VDHtHkqSs7IMU/j/zL3L4I8MtsbfF3ARkrZf9kgibMVLfwd1JVIcGfyefvyrmHJHmeblV
	 rPQ3PJlhptZEri+17gx9vJ3Qe5v/hKzW/HtXeGMtmbkF8nX80jy5PhHvb8CDkx5VHbv4y
	 AzeQWsZZFYIAVhhFH618pWPAiJlzJBB4StHaBz3AlCOmBDF0LIgFN1fVyHOPf92fj8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b="ALIT/0X4";
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A21606A322
	for <linux-can@vger.kernel.org>; Mon,  9 Nov 2026 13:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98A21606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=ALIT/0X4
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e987a2ba0cso4252585ad.3
        for <linux-can@vger.kernel.org>; Mon, 09 Nov 2026 05:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1794230193; x=1794834993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ssSp4uhg2na5mlS8fgRxXLVgT3tscKVQqq7yr3h9PBo=;
        b=ALIT/0X4BxiJfDHjSHQbFDH8SG3CxTLp+9ol0TmMGSKuMkCdhkjvTu5UL85x0NK/CU
         T1EbNbJQd12P+6g00X23CkTKXeUP5JgSeyMqztzThpOQfVFdldotR3qMqmDVuFUfWka4
         N8CsHPtJ2eT+Qbo2avNCn+suFhY2iyT0kXWlvzMqHRnTkCTAu5YhtA73fMgjO19kJLBA
         vImtQiI69XDN8MB3JxIaaokinjNarqEa+zyLvKgrCe+iDlxbVDIOkpFVDfyStkwo7jDD
         PSC4oxd+RzzYy8dNToLVX4vvpLriNGmep6uZ1vxbHeRDzDjIrl5b7/tvw7bzJgrAnT61
         FHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794230193; x=1794834993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssSp4uhg2na5mlS8fgRxXLVgT3tscKVQqq7yr3h9PBo=;
        b=tRrffAEEO1b2bm7KPatjKmurVvV2+1gVoNZVeafvsCdn4ZtEEqQO0TXmusfbDGCkWY
         cn+6uA9RBi3Hdq3vKMHK/SGBdbVcqOKu+90hD8s6hs7zd7FABLKwKq5vwQ51OS9zkbOF
         qs3XqLlg7+HPfqYRn49Z72gR1Wor77wNxlwt4gQKA6USVIIAVDmICvwHVsoBjS0C81QL
         jZY77qYSwkkbOolOa8BFuae/HeV3NwTG2PTO7QY4B8SoC50LoH3QlWsmBZNcu30U1d4s
         LLjQ0l15r+6yukOWjd4GcCyXLdbDlqa/M/HX3RXrkZwFTO3o5iKH4edvUH/rgOzV15UA
         k5VQ==
X-Gm-Message-State: APuU4Z/6Ie3QZgqFhVcfShHJRgKwQ22K7m6egGySpXHNEQptM11KPsFm
	FiG/LCVE4xv5D2lnPp4fQdaHVRHkqeCMQc5U7IaxzbcxomnqlLA1OwkoqG+UGZm0KFgvPcdJ5HE
	Laxr7qWye
X-Gm-Gg: AYBFou3H5EcJg01g/O3IYAIc0z0z/EW/uiuaZjuVdtcM2jhxPMjWWweQtQSCtErGiEA
	49ujw7W25msTSDsRJI28UfGCFjJGGwgIqgsFWTbYv7Ehea5EpuWeHk+ALQujY2E9OPwleEVrzZv
	9ZiNHszELy0IHNBTExrcauqN+xw0HkQcKIKxCgDf++ennwNVbPZLJGa3bBKTFrqAGeW72uKdESB
	dlb/vgYXzc2OBX9AXD9izd5odaJ2p4tI2PZ4vzpXQUqB48DeQSZbqhnekVex+yQjJePwsNhEVtT
	bPlizerPs71m/1RZ387FLTiaY6SitBgrh8L2WCMhJNldrUZ2Xvz8J8/AatXjUzqpXDQIg8bkxBC
	HdmlV/QtE7BCN8CQUhUQUN3tAd110fxNNFW5Ab8c6TE0x+uQJbOdm8/6XPvCuOhTEMjT6IgBqwa
	q+yu3aEIvPi/gdL65Sr5NigorCA79apZrdrEt7A8Y32c32f9POG+MlkRSTjoNQz4YHNlRlvi+oE
	NPOfELTOkP29WWq9M6+4a+4iQzt1VK70jl4rNQR/cWIzoIh9paOpWUi3MTMI9MypuOjV0ZJpVPr
	YaK6mn2WBDnuKMrrcWohf+3OI9Rv64uJaXlWpZFg7Sm+licXAFT5NuVmGHXp
X-Received: by 2002:a17:903:1a0b:b0:2ed:2d5b:d42 with SMTP id d9443c01a7336-2ed837a64d5mr38980195ad.52.1794230192571;
        Mon, 09 Nov 2026 05:16:32 -0800 (PST)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed815e7416sm11221095ad.17.2026.11.09.05.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 05:16:31 -0800 (PST)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	bst@pengutronix.de,
	lkp@intel.com,
	maxime.jayat@mobile-devices.fr,
	ecathinds@gmail.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v8 0/2] can: j1939: fix TX timer reference leak
Date: Mon,  9 Nov 2026 13:16:22 +0000
Message-ID: <20261109131624.276943-1-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can: j1939: fix TX timer reference leak

Hi Linux kernel maintainers,

We found a J1939 session-reference leak in net/can/j1939/transport.c. An
unprivileged local user can exercise the receive path on systems that allow
unprivileged user namespaces, by creating user/network namespaces and a
vxcan pair. An attached CAN peer can trigger the same path by sending J1939
frames. Repeated ETP DAT processing can retain sessions without bound. In
the PoC, the 2 MiB ETP RTS size is passed to `alloc_skb(size, GFP_ATOMIC)`;
the resulting skb is queued on the session. The PoC sends only the first DPO
block, but a leaked session pins the full requested-size skb, as well as
priv/netdev references. Repeating sessions can cause unbounded memory growth
and block device unregistration.

Exact-v8 validation: the KASAN/lockdep and lower-load KCSAN/lockdep runs
completed without relevant reports. A higher-load KCSAN attempt produced an
unarchived printk warning, so it is not a clean pass. Details and limits
are recorded below.

---- details below ----

An LLM was used to help create this patch.

This bug is tracked at: https://bugtracker.nebusec.ai/f/11143 (11143)

Bug details:

For an RX ETP session, pkt.last remains zero: RTS/DPO reception does not
set it, so pkt.rx >= pkt.last is true from the first accepted DAT.
j1939_xtp_rx_dat_one() therefore schedules the TX timer through do_cts_eoma
for accepted DATs, and repeated DATs can schedule it again without
advancing pkt.rx. The reproducer sends duplicate DAT 255 at a non-final
DPO block boundary as one concrete repeated-DAT case; earlier DATs may also
schedule the timer. If multiple starts occur before HRTIMER_SOFTIRQ runs,
each hrtimer_start() updates the same timer, while the old code acquired a
new session reference for every restart and the timer released only one.

The leaked references keep completed sessions alive, along with their skb
queues, j1939_priv references, and net_device tracker references. New RTS
sessions can be created after deactivation, so a peer can repeat the leak,
causing unbounded memory growth and potentially preventing device
unregistration. The fix tracks one reference across each queued/running
timer lifetime and reuses it when rearming.

Baseline trace excerpt: the second start updated an already armed timer
(`was_armed=1`):

             poc-389     [001] d.s2.   200.601390: hrtimer_start: hrtimer=ffffa3da4a2bc4b8 function=j1939_tp_txtimer expires=200464843123 softexpires=200464843123 mode=REL|SOFT was_armed=0
             poc-390     [000] d.s2.   200.601400: hrtimer_start: hrtimer=ffffa3da4a2bc4b8 function=j1939_tp_txtimer expires=200464853253 softexpires=200464853253 mode=REL|SOFT was_armed=1

Changes in v8:
- Keep Patch 1's commit message focused on timer-reference behavior; describe
  the detailed remote trigger and impact in this cover letter.
- Rename the locked helper to describe publication of session shutdown
  intent; do not add lock operations or change behavior.
- Rebase on net/main 30c71476d842.
- Use the legacy-compatible CAN frame length field in the reproducer so it
  builds with older distribution UAPI headers.
- Explain that the PoC's RTS size allocates a full-size receive skb even
  though the PoC sends only the first DPO block.

Link: https://lore.kernel.org/all/cover.1793946215.git.zihanx@nebusec.ai/

Reproducer:

The reproducer uses raw CAN frames over namespace-local vxcan peers. It
advertises a 2 MiB ETP transfer. The RX RTS path passes that requested size
to `j1939_session_fresh_new()`, which allocates an skb with
`alloc_skb(size, GFP_ATOMIC)` and queues it on the session. The PoC sends DPO
for the first 255-packet block and DAT packets 1 through 254, then
concurrently sends duplicate DAT packet 255 at this non-final block boundary.
Thus only the first block is sent, but the leaked session pins the entire
requested-size skb. In the selected baseline RX
ETP path, pkt.last remains zero, so earlier accepted DATs may also schedule
the timer; the duplicate burst is one repeated-DAT case, not the sole possible
scheduling point. The baseline trace shows the same timer being restarted
while already armed (`was_armed=1`), but does not identify which incoming DAT
caused each start. Thus the trace confirms timer rearming, not
packet-level causality.

The supplied original PoC materials from Linux 6.12.95 also contain a
separate OOM-conversion run. After accumulating leaked sessions, a root-run
Python memory hog forced OOM with `vm.panic_on_oom=2`; the resulting OOM
panic is not a memory-safety crash. The timer-restart run itself did not
crash. The patched v8 PoC runs below did not crash either.

Packetdrill was not used: this test injects CAN_RAW over vxcan to exercise
CAN/J1939 link-layer handling. Upstream packetdrill tests TCP/UDP/IP stacks
over TUN or physical-network packet paths; it does not directly express
CAN/J1939 ETP on vxcan. The custom C sender constructs the frames and
coordinates concurrent duplicate DATs.

Compile the reproducer with:

    gcc -O2 -Wall -Wextra -Werror -pthread -static -o poc poc.c

Run it as an unprivileged account with user/network namespace support:

    unshare -Urn sh -c 'ip link add vxcan0 type vxcan peer name vxcan1 && ip link set vxcan0 up && ip link set vxcan1 up && ./poc vxcan0 vxcan1 2097152 4 32 4096 1'

The exact v8 source is based on net/main 30c71476d842. It was built with
KASAN, KCSAN, lockdep and timer debug objects enabled; builds used -j1.

Exact-v8 runtime validation in a 2 vCPU, 2 GB x86 QEMU guest, using an
unprivileged user in user/network namespaces and local vxcan peers:

- KASAN + lockdep: 4 ETP sessions, 8 workers, 256 duplicate DAT frames per
  worker; all completed (exit 0), taint 0, no KASAN/refcount/timer-debug/
  lockdep warning in dmesg.
- KCSAN + lockdep: 1 ETP session, 4 workers, 64 duplicate DAT frames per
  worker; completed (exit 0), taint 0, no KCSAN/lockdep warning in dmesg.
- One higher-load KCSAN attempt was observed in live QEMU output to report
  a generic printk ring-buffer race (`prb_first_seq` / `prb_reserve`) during
  heavy netdev logging. The stack pointed to printk/console and `netdev_info`,
  not J1939 timer fields. The raw report was not preserved, so the
  classification cannot be independently verified; this is not a clean pass.

The patched PoC runs exercised the traffic path but did not crash. The
original OOM-conversion panic log is included here to distinguish it from a
memory-corruption crash; direct timer-path evidence is the `was_armed=1`
trace.

----BEGIN crash log----

[ 2096.279891][T11966] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled

-----END crash log-----

------BEGIN PoC------
#define _GNU_SOURCE

#include <errno.h>
#include <linux/can.h>
#include <linux/can/j1939.h>
#include <linux/can/raw.h>
#include <net/if.h>
#include <poll.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#ifndef SYS_sendmmsg
#define SYS_sendmmsg 307
#endif

#define LOCAL_SA 0x80
#define REMOTE_SA_BASE 0x81
#define APP_PGN_BASE 0x01f100

#define J1939_ETP_PGN_CTL 0x00c800
#define J1939_ETP_PGN_DAT 0x00c700

#define J1939_ETP_CMD_ABORT 0xff
#define J1939_ETP_CMD_CTS 0x15
#define J1939_ETP_CMD_DPO 0x16
#define J1939_ETP_CMD_RTS 0x14

#define DEFAULT_SIZE (1024U * 1024U)
#define DEFAULT_DUPLICATES 256U
#define DEFAULT_SESSIONS 4096U
#define DEFAULT_THREADS 8U
#define FIRST_BLOCK_PKTS 255U

struct params {
	const char *tx_ifname;
	const char *rx_ifname;
	uint32_t session_size;
	uint32_t sessions;
	uint32_t threads;
	uint32_t duplicates;
	bool verbose;
};

struct can_burst {
	struct can_frame *frames;
	struct mmsghdr *msgs;
	struct iovec *iovecs;
	unsigned int nframes;
};

struct worker_ctx {
	int fd;
	int cpu;
	struct can_burst burst;
};

static pthread_barrier_t start_barrier;
static pthread_barrier_t done_barrier;
static volatile sig_atomic_t stop_workers;

static void die(const char *what);

static int sendmmsg_compat(int fd, struct mmsghdr *msgvec, unsigned int vlen,
			   unsigned int flags)
{
	return syscall(SYS_sendmmsg, fd, msgvec, vlen, flags);
}

static unsigned int sendmmsg_all(int fd, struct mmsghdr *msgvec,
				 unsigned int vlen, const char *what)
{
	unsigned int sent = 0;

	while (sent < vlen) {
		int ret = sendmmsg_compat(fd, &msgvec[sent], vlen - sent, 0);

		if (ret < 0)
			die(what);
		if (!ret) {
			errno = EIO;
			die(what);
		}
		sent += ret;
	}

	return sent;
}

static void die(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static void barrier_wait_or_die(pthread_barrier_t *barrier, const char *what)
{
	int ret = pthread_barrier_wait(barrier);

	if (ret != 0 && ret != PTHREAD_BARRIER_SERIAL_THREAD) {
		errno = ret;
		die(what);
	}
}

static unsigned int parse_u32(const char *arg, const char *what)
{
	char *endp;
	unsigned long value;

	errno = 0;
	value = strtoul(arg, &endp, 0);
	if (errno || *endp || value > UINT32_MAX) {
		fprintf(stderr, "invalid %s: %s\n", what, arg);
		exit(EXIT_FAILURE);
	}

	return (unsigned int)value;
}

static void pin_to_cpu(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	if (pthread_setaffinity_np(pthread_self(), sizeof(set), &set))
		perror("pthread_setaffinity_np");
}

static canid_t make_can_id(uint8_t prio, uint32_t pgn, uint8_t sa, uint8_t da)
{
	canid_t can_id;

	can_id = CAN_EFF_FLAG | ((canid_t)prio << 26) | ((canid_t)pgn << 8) | sa;
	if (((pgn >> 8) & 0xff) < 240)
		can_id |= (canid_t)da << 8;

	return can_id;
}

static int ifindex_by_name(const char *ifname)
{
	unsigned int ifindex = if_nametoindex(ifname);

	if (!ifindex) {
		errno = ENODEV;
		die("if_nametoindex");
	}

	return (int)ifindex;
}

static int make_raw_socket(int ifindex)
{
	struct sockaddr_can addr = {
		.can_family = AF_CAN,
		.can_ifindex = ifindex,
	};
	int fd;
	int one = 1;

	fd = socket(PF_CAN, SOCK_RAW, CAN_RAW);
	if (fd < 0)
		die("socket(CAN_RAW)");

	if (setsockopt(fd, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS, &one,
		       sizeof(one)) < 0)
		die("setsockopt(CAN_RAW_RECV_OWN_MSGS)");

	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die("bind(CAN_RAW)");

	return fd;
}

static int make_j1939_listener(int ifindex)
{
	struct sockaddr_can addr = {
		.can_family = AF_CAN,
		.can_ifindex = ifindex,
		.can_addr.j1939 = {
			.name = 0,
			.pgn = J1939_NO_PGN,
			.addr = LOCAL_SA,
		},
	};
	int fd;

	fd = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	if (fd < 0)
		die("socket(CAN_J1939)");

	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die("bind(CAN_J1939)");

	return fd;
}

static void send_frame(int fd, const struct can_frame *frame)
{
	ssize_t written = write(fd, frame, sizeof(*frame));

	if (written != (ssize_t)sizeof(*frame))
		die("write(can_frame)");
}

static void build_etp_rts(struct can_frame *frame, uint8_t sa, uint8_t da,
			  uint32_t size, uint32_t app_pgn)
{
	memset(frame, 0, sizeof(*frame));
	frame->can_id = make_can_id(6, J1939_ETP_PGN_CTL, sa, da);
	frame->can_dlc = 8;
	frame->data[0] = J1939_ETP_CMD_RTS;
	frame->data[1] = (size >> 0) & 0xff;
	frame->data[2] = (size >> 8) & 0xff;
	frame->data[3] = (size >> 16) & 0xff;
	frame->data[4] = (size >> 24) & 0xff;
	frame->data[5] = (app_pgn >> 0) & 0xff;
	frame->data[6] = (app_pgn >> 8) & 0xff;
	frame->data[7] = (app_pgn >> 16) & 0xff;
}

static void build_etp_dpo(struct can_frame *frame, uint8_t sa, uint8_t da,
			  uint32_t app_pgn)
{
	memset(frame, 0, sizeof(*frame));
	frame->can_id = make_can_id(6, J1939_ETP_PGN_CTL, sa, da);
	frame->can_dlc = 8;
	frame->data[0] = J1939_ETP_CMD_DPO;
	frame->data[1] = FIRST_BLOCK_PKTS;
	frame->data[2] = 0;
	frame->data[3] = 0;
	frame->data[4] = 0;
	frame->data[5] = (app_pgn >> 0) & 0xff;
	frame->data[6] = (app_pgn >> 8) & 0xff;
	frame->data[7] = (app_pgn >> 16) & 0xff;
}

static void build_etp_abort(struct can_frame *frame, uint8_t sa, uint8_t da,
			    uint32_t app_pgn)
{
	memset(frame, 0, sizeof(*frame));
	frame->can_id = make_can_id(6, J1939_ETP_PGN_CTL, sa, da);
	frame->can_dlc = 8;
	frame->data[0] = J1939_ETP_CMD_ABORT;
	frame->data[1] = 1;
	frame->data[2] = 0xff;
	frame->data[3] = 0xff;
	frame->data[4] = 0xff;
	frame->data[5] = (app_pgn >> 0) & 0xff;
	frame->data[6] = (app_pgn >> 8) & 0xff;
	frame->data[7] = (app_pgn >> 16) & 0xff;
}

static void build_etp_terminal_data(struct can_frame *frame, uint8_t remote_sa)
{
	memset(frame, 0, sizeof(*frame));
	frame->can_id = make_can_id(6, J1939_ETP_PGN_DAT, remote_sa, LOCAL_SA);
	frame->can_dlc = 8;
	frame->data[0] = FIRST_BLOCK_PKTS;
	memset(&frame->data[1], 'Z', 7);
}

static void free_burst(struct can_burst *burst)
{
	free(burst->iovecs);
	free(burst->msgs);
	free(burst->frames);
	memset(burst, 0, sizeof(*burst));
}

static void drain_raw_rx(int fd)
{
	struct pollfd pfd = {
		.fd = fd,
		.events = POLLIN,
	};

	for (;;) {
		struct can_frame frame;
		int ret = poll(&pfd, 1, 0);

		if (ret <= 0)
			return;

		if (read(fd, &frame, sizeof(frame)) < 0) {
			if (errno == EAGAIN || errno == EWOULDBLOCK)
				return;
			die("read(raw drain)");
		}
	}
}

static bool match_ctl_cmd(const struct can_frame *frame, uint8_t sa, uint8_t da,
			  uint32_t pgn, uint8_t cmd)
{
	uint32_t frame_pgn;
	uint8_t frame_sa;
	uint8_t frame_da = J1939_NO_ADDR;

	if (!(frame->can_id & CAN_EFF_FLAG))
		return false;

	frame_sa = frame->can_id & 0xff;
	frame_pgn = (frame->can_id >> 8) & J1939_PGN_MAX;
	if (((frame_pgn >> 8) & 0xff) < 240) {
		frame_da = frame_pgn & 0xff;
		frame_pgn &= J1939_PGN_PDU1_MAX;
	}

	return frame_sa == sa && frame_da == da &&
	       frame_pgn == pgn && frame->can_dlc >= 1 &&
	       frame->data[0] == cmd;
}

static bool wait_for_cts(int raw_fd, uint8_t remote_sa, uint32_t app_pgn,
			 bool verbose)
{
	struct pollfd pfd = {
		.fd = raw_fd,
		.events = POLLIN,
	};
	struct timespec start;

	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)
		die("clock_gettime");

	for (;;) {
		struct can_frame frame;
		struct timespec now;
		int elapsed_ms;
		int timeout_ms;
		int ret;

		if (clock_gettime(CLOCK_MONOTONIC, &now) < 0)
			die("clock_gettime");

		elapsed_ms = (int)((now.tv_sec - start.tv_sec) * 1000 +
				   (now.tv_nsec - start.tv_nsec) / 1000000);
		timeout_ms = 1000 - elapsed_ms;
		if (timeout_ms <= 0)
			return false;

		ret = poll(&pfd, 1, timeout_ms);
		if (ret < 0)
			die("poll(raw)");
		if (ret == 0)
			return false;

		if (!(pfd.revents & POLLIN))
			continue;

		if (read(raw_fd, &frame, sizeof(frame)) < 0)
			die("read(raw)");

		if (match_ctl_cmd(&frame, LOCAL_SA, remote_sa, J1939_ETP_PGN_CTL,
				  J1939_ETP_CMD_CTS)) {
			if (verbose) {
				printf("saw initial CTS for pgn=0x%05x remote_sa=0x%02x\n",
				       app_pgn, remote_sa);
				fflush(stdout);
			}
			return true;
		}
	}
}

static void init_burst(struct can_burst *burst, unsigned int nframes)
{
	memset(burst, 0, sizeof(*burst));
	burst->nframes = nframes;
	burst->frames = calloc(nframes, sizeof(*burst->frames));
	burst->msgs = calloc(nframes, sizeof(*burst->msgs));
	burst->iovecs = calloc(nframes, sizeof(*burst->iovecs));
	if (!burst->frames || !burst->msgs || !burst->iovecs)
		die("calloc(burst)");
}

static void finalize_burst(struct can_burst *burst)
{
	unsigned int i;

	for (i = 0; i < burst->nframes; i++) {
		burst->iovecs[i].iov_base = &burst->frames[i];
		burst->iovecs[i].iov_len = sizeof(burst->frames[i]);
		burst->msgs[i].msg_hdr.msg_iov = &burst->iovecs[i];
		burst->msgs[i].msg_hdr.msg_iovlen = 1;
	}
}

static void build_prefix_burst(struct can_burst *burst, uint8_t remote_sa,
			       uint32_t app_pgn)
{
	unsigned int i;

	init_burst(burst, FIRST_BLOCK_PKTS);
	build_etp_dpo(&burst->frames[0], remote_sa, LOCAL_SA, app_pgn);

	for (i = 1; i < FIRST_BLOCK_PKTS; i++) {
		memset(&burst->frames[i], 0, sizeof(burst->frames[i]));
		burst->frames[i].can_id = make_can_id(6, J1939_ETP_PGN_DAT,
						      remote_sa, LOCAL_SA);
		burst->frames[i].can_dlc = 8;
		burst->frames[i].data[0] = i;
		memset(&burst->frames[i].data[1], 'A' + (i % 26), 7);
	}

	finalize_burst(burst);
}

static void build_terminal_burst(struct can_burst *burst, uint8_t remote_sa,
				 unsigned int duplicates)
{
	unsigned int i;

	free_burst(burst);
	init_burst(burst, duplicates);

	for (i = 0; i < duplicates; i++)
		build_etp_terminal_data(&burst->frames[i], remote_sa);

	finalize_burst(burst);
}

static void *worker_main(void *arg)
{
	struct worker_ctx *ctx = arg;

	pin_to_cpu(ctx->cpu);

	for (;;) {
		barrier_wait_or_die(&start_barrier, "pthread_barrier_wait(start)");
		if (stop_workers)
			break;

		sendmmsg_all(ctx->fd, ctx->burst.msgs, ctx->burst.nframes,
			     "sendmmsg(worker)");

		barrier_wait_or_die(&done_barrier, "pthread_barrier_wait(done)");
	}

	return NULL;
}

static void init_workers(struct worker_ctx *workers, pthread_t *tids,
			 int ifindex, unsigned int threads, int ncpus)
{
	unsigned int i;

	if (pthread_barrier_init(&start_barrier, NULL, threads + 1))
		die("pthread_barrier_init(start)");
	if (pthread_barrier_init(&done_barrier, NULL, threads + 1))
		die("pthread_barrier_init(done)");

	for (i = 0; i < threads; i++) {
		workers[i].fd = make_raw_socket(ifindex);
		workers[i].cpu = i % ncpus;
		if (pthread_create(&tids[i], NULL, worker_main, &workers[i]))
			die("pthread_create");
	}
}

static void join_workers(struct worker_ctx *workers, pthread_t *tids,
			 unsigned int threads)
{
	unsigned int i;

	stop_workers = 1;
	barrier_wait_or_die(&start_barrier, "pthread_barrier_wait(stop)");

	for (i = 0; i < threads; i++) {
		if (pthread_join(tids[i], NULL))
			die("pthread_join");
		free_burst(&workers[i].burst);
		close(workers[i].fd);
	}

	pthread_barrier_destroy(&start_barrier);
	pthread_barrier_destroy(&done_barrier);
}

static void run_session(int raw_fd, struct worker_ctx *workers,
			uint32_t size, uint32_t threads, uint32_t duplicates,
			uint32_t session_idx, bool verbose)
{
	struct can_frame rts;
	struct can_frame abort;
	struct can_burst prefix = { 0 };
	uint8_t remote_sa;
	uint32_t app_pgn;
	unsigned int i;
	unsigned int sa_span = J1939_MAX_UNICAST_ADDR - REMOTE_SA_BASE + 1;

	remote_sa = REMOTE_SA_BASE + (session_idx % sa_span);
	app_pgn = APP_PGN_BASE + (session_idx % 0x100);

	build_etp_rts(&rts, remote_sa, LOCAL_SA, size, app_pgn);
	send_frame(raw_fd, &rts);

	if (!wait_for_cts(raw_fd, remote_sa, app_pgn, verbose)) {
		fprintf(stderr,
			"timed out waiting for initial CTS: session=%u remote_sa=0x%02x pgn=0x%05x size=%u\n",
			session_idx, remote_sa, app_pgn, size);
		exit(EXIT_FAILURE);
	}

	build_prefix_burst(&prefix, remote_sa, app_pgn);
	/* Ensure the receiver processes DPO before the data packet burst. */
	send_frame(raw_fd, &prefix.frames[0]);
	usleep(1000);
	sendmmsg_all(raw_fd, &prefix.msgs[1], prefix.nframes - 1,
		     "sendmmsg(prefix)");
	free_burst(&prefix);

	for (i = 0; i < threads; i++)
		build_terminal_burst(&workers[i].burst, remote_sa, duplicates);

	barrier_wait_or_die(&start_barrier, "pthread_barrier_wait(start-main)");
	barrier_wait_or_die(&done_barrier, "pthread_barrier_wait(done-main)");

	build_etp_abort(&abort, remote_sa, LOCAL_SA, app_pgn);
	send_frame(raw_fd, &abort);
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"usage: %s [tx_ifname] [rx_ifname] [size] [sessions] [threads] [duplicates_per_thread] [verbose]\n",
		prog);
	exit(EXIT_FAILURE);
}

int main(int argc, char **argv)
{
	struct params params = {
		.tx_ifname = "vcan0",
		.rx_ifname = "vcan0",
		.session_size = DEFAULT_SIZE,
		.sessions = DEFAULT_SESSIONS,
		.threads = DEFAULT_THREADS,
		.duplicates = DEFAULT_DUPLICATES,
		.verbose = false,
	};
	struct worker_ctx *workers;
	pthread_t *tids;
	int ifindex;
	int rx_ifindex;
	int raw_fd;
	int j1939_fd;
	int ncpus;
	unsigned int i;

	if (argc > 8)
		usage(argv[0]);

	if (argc >= 2)
		params.tx_ifname = argv[1];
	if (argc >= 3)
		params.rx_ifname = argv[2];
	if (argc >= 4)
		params.session_size = parse_u32(argv[3], "size");
	if (argc >= 5)
		params.sessions = parse_u32(argv[4], "sessions");
	if (argc >= 6)
		params.threads = parse_u32(argv[5], "threads");
	if (argc >= 7)
		params.duplicates = parse_u32(argv[6], "duplicates");
	if (argc >= 8)
		params.verbose = parse_u32(argv[7], "verbose") != 0;

	if (params.session_size <= 1785) {
		fprintf(stderr, "size must be > 1785 to force ETP\n");
		return EXIT_FAILURE;
	}
	if (!params.sessions || !params.threads || !params.duplicates)
		usage(argv[0]);

	ncpus = sysconf(_SC_NPROCESSORS_ONLN);
	if (ncpus < 1)
		die("sysconf(_SC_NPROCESSORS_ONLN)");

	workers = calloc(params.threads, sizeof(*workers));
	tids = calloc(params.threads, sizeof(*tids));
	if (!workers || !tids)
		die("calloc(workers)");

	ifindex = ifindex_by_name(params.tx_ifname);
	rx_ifindex = ifindex_by_name(params.rx_ifname);
	j1939_fd = make_j1939_listener(rx_ifindex);
	raw_fd = make_raw_socket(ifindex);
	init_workers(workers, tids, ifindex, params.threads, ncpus);

	printf("tx_if=%s(%d) rx_if=%s(%d) size=%u sessions=%u threads=%u duplicates_per_thread=%u\n",
	       params.tx_ifname, ifindex, params.rx_ifname, rx_ifindex,
	       params.session_size, params.sessions, params.threads,
	       params.duplicates);
	fflush(stdout);

	for (i = 0; i < params.sessions; i++) {
		drain_raw_rx(raw_fd);
		run_session(raw_fd, workers, params.session_size, params.threads,
			    params.duplicates, i, params.verbose);
		if ((i + 1) % 16 == 0 || params.verbose) {
			printf("completed %u sessions\n", i + 1);
			fflush(stdout);
		}
	}

	join_workers(workers, tids, params.threads);
	close(raw_fd);
	close(j1939_fd);
	free(tids);
	free(workers);

	return 0;
}
------END PoC--------

Best regards,
Zihan Xi

Zihan Xi (2):
  can: j1939: account for timer references across rearm
  can: j1939: serialize TX with session shutdown

 net/can/j1939/j1939-priv.h |  14 +
 net/can/j1939/transport.c  | 575 +++++++++++++++++++++++++++++++------
 2 files changed, 499 insertions(+), 90 deletions(-)

-- 
2.43.0

