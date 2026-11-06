Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943320;
	b=lqmyfVw4ccdvHMaa7irTIaBJCtr+z836v8WzpsNar9RCUTnpiVOsx9BnS2wYFkpPqlsG
	 Om/KU99+szw8802Fr2YOB9ASf5/iBYnZD/2jYhXs7kQu4ntG8adCG3HWLOsMYaQm6Vkzf
	 FKOYn2T2ljlj4w1Eu/pxIy8fAmRGAbGA4I2QBclEYTFgqEwNYEymtAVBDmD2AZLjKKIML
	 C7N6O7UqNXt8A/WIihhUxKrYx83QNLXdHZuR/ZmmShLPhEypwr8UmeIMKK8XUKjGy4bd0
	 kfeyn7t84kqfQ1HurRmUwRMsxcHSDyN0BDRwmfSLEmy73MJ9QSSWSAG5LlwU/nMhcYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943320;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YD0WMXfyYPEaM2VDLe4N8Gpd016qkpUV23TGdYPWKlQ=;
	b=Uf/PPfoP1jKajZkzN6Ls6UbK/Cq2KVzjDzFIMKnEREIzdpM+ZCG+8VTYEs/TyXgPMHn8
	 9YjvT1ADadjitUsvxg/AncF4ob91li1cWwv9waKc1Co7T86JQi5LvG7FT4uYDRYpZ4P1P
	 /EAZHIv6zyxYnT6HqCE/iHA6WE4UpyPkhrPz7THJrJXlEeOIY7+rvFXAtYiiGffoXD5ZX
	 QEeXVFg/seNq4dfQWFY9PBsqpf+Q7Y3zADYUjqMmGQt9tw8RDfQ2bEchfX2NHFabSAV0p
	 rtzzjrlWCpvLbcgFpfzdxo7SNqXN2BX7ivfO6r2r/Q+RRrHprrvS3StxNKM5P7Uv4KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhhOAgmx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F86606A326;
	Fri,  6 Nov 2026 05:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhhOAgmx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8FF1F0089F;
	Fri,  6 Nov 2026 05:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793943319;
	bh=YD0WMXfyYPEaM2VDLe4N8Gpd016qkpUV23TGdYPWKlQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dhhOAgmxoizO5KAIPC7h9eg710WCobLPmX0G6lChRZEJehq3KqrleYfJLZJ2pmb1g
	 l0GwMSb3JvUFZcPeRCtmhg8Z6cHl37+15vTqDcKrTtSqJARJ+k9fc0xt+u8MABDdXO
	 z6/okmTDJRalzhKVjawdacCpxWW8ugqS7cN6nPLBuYCgLhQVXZIJotOVnS8yv/dmJa
	 ATzd6DMiIrSwuY54w9JeWA46VD7ohZtsZuQnkHaTPWVIFH1RPGL44dANdNGZ5Cf53P
	 GEoASI2qLd6tZN9t1PjhR2jagJF3v/Sc0B3LMkJOdsmtHNo6eL9uYRHmvq1nhlCWZG
	 EXWxBj4E0uTTQ==
Subject: Re: [PATCH can-next v2 2/9] selftests: can: add J1939 test helper
 header and library
From: netdev-bot+sashiko@kernel.org
To: o.rempel@pengutronix.de
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
 shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
 quchaosheng000406@163.com, penguin-kernel@I-love.SAKURA.ne.jp,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 05:35:17 +0000
Message-ID: <179394331774.488853.9726002978646630085@kernel.org>
In-Reply-To: <20261104-j1939-selftests-v2-2-cf797c83317b@pengutronix.de>
References: <20261104-j1939-selftests-v2-2-cf797c83317b@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] selftests: can: silent skip in j1939_test_main() when protocol is
  missing

--

> diff --git a/tools/testing/selftests/net/can/j1939_tests.h b/tools/testing/selftests/net/can/j1939_tests.h
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/j1939_tests.h
> @@ -0,0 +1,724 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> +/*
> + * Shared helpers for the J1939 selftests.
> + *
> + * The individual tests are standalone kselftest binaries, so the common
> + * boilerplate (interface lookup, socket open/connect, timed receive, CAN-ID
> + * encoding and the CANIF/main() plumbing) lives here as static inline helpers.
> + *
> + * The including .c file must include "kselftest_harness.h" before this header
> + * (j1939_test_main() uses KSFT_SKIP and test_harness_run()).
> + *
> + * Each test binary is run by its .sh wrapper (see j1939_lib.sh), which sets up
> + * the vcan interface and passes its name in the CANIF environment variable.
> + *
> + * Helpers named *_ok() return true on success and false on failure, with
> + * errno set where a system call failed. Helpers that return a file
> + * descriptor or a length return -1 on failure.
> + *
> + * Timing modes: timer checks use relaxed bounds by default, so that slow
> + * machines such as QEMU in CI pass. Set J1939_STRICT_TIMING in the
> + * environment (any value) for tight bounds on a real machine.
> + */
> +#ifndef __SELFTESTS_NET_CAN_J1939_TESTS_H__
> +#define __SELFTESTS_NET_CAN_J1939_TESTS_H__
> +
> +#include <limits.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <poll.h>
> +#include <stdint.h>
> +#include <errno.h>
> +#include <time.h>
> +
> +#include <sys/socket.h>
> +#include <sys/ioctl.h>
> +#include <net/if.h>
> +#include <linux/if.h>
> +#include <linux/can.h>
> +#include <linux/can/raw.h>
> +#include <linux/can/j1939.h>
> +
> +#include "clock-helpers.h"
> +
> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(a)		(sizeof(a) / sizeof((a)[0]))
> +#endif
> +#ifndef DIV_ROUND_UP
> +#define DIV_ROUND_UP(n, d)	(((n) + (d) - 1) / (d))
> +#endif
> +
> +/*
> + * How long to wait for an expected frame. Not a protocol timer: a guess with
> + * room for a slow VM.
> + */
> +#define J1939_RECV_TIMEOUT_MS	2000
> +
> +/*
> + * Timeout for a check that expects no frame. Long enough that a real
> + * local frame would have arrived, so a timeout means "nothing came".
> + * Much shorter than J1939_RECV_TIMEOUT_MS, to keep the test fast. A guess.
> + */
> +#define J1939_NEG_RECV_TIMEOUT_MS	300
> +_Static_assert(J1939_NEG_RECV_TIMEOUT_MS < J1939_RECV_TIMEOUT_MS,
> +	       "J1939_NEG_RECV_TIMEOUT_MS must be the shorter timeout");
> +
> +/* Send priority of a new J1939 socket, see j1939_sk_init() in the kernel. */
> +#define J1939_PRIO_DEFAULT	6
> +
> +/* Unused data bytes are sent as 0xff (SAE J1939-21:2001 Figures 14, 15). */
> +#define J1939_FILL_BYTE		0xff
> +
> +/*
> + * PGN fields: PF is the second byte, PS the low byte. A PF of at least
> + * J1939_PDU2_PF_MIN selects PDU2: broadcast, and PS is not an address
> + * (SAE J1939-21:2001 sections 5.1.2 and 5.2.5).
> + */
> +#define J1939_PGN_PF_SHIFT	CHAR_BIT	/* below PF: the PS byte */
> +#define J1939_PDU2_PF_MIN	0xf0
> +#define J1939_PF(pgn)		(((pgn) >> J1939_PGN_PF_SHIFT) & UINT8_MAX)
> +#define J1939_IS_PDU1(pgn)	(J1939_PF(pgn) < J1939_PDU2_PF_MIN)
> +/* Data Page bit of a PGN (SAE J1939-21:2001 section 5.2.3) */
> +#define J1939_PGN_DP		0x10000
> +
> +/*
> + * Fields of the 29-bit CAN id (SAE J1939-21:2001 section 5.2): the priority,
> + * then the PGN, whose PS byte holds the destination of a PDU1 frame, then
> + * the source address in the low byte. The j1939_id_*() decoders mask their
> + * field, so they take a can_id with the CAN_*_FLAG bits still set.
> + */
> +#define J1939_ID_PRIO_BITS	3
> +#define J1939_ID_PRIO_SHIFT	(CAN_EFF_ID_BITS - J1939_ID_PRIO_BITS)
> +#define J1939_ID_PRIO_MASK	((1U << J1939_ID_PRIO_BITS) - 1)
> +#define J1939_ID_PGN_SHIFT	CHAR_BIT	/* below the PGN: the SA byte */
> +_Static_assert((J1939_PGN_MAX + 1) << J1939_ID_PGN_SHIFT ==
> +	       1U << J1939_ID_PRIO_SHIFT,
> +	       "the PGN field must end where the priority starts");
> +
> +static inline int j1939_id_prio(canid_t id)
> +{
> +	return (id >> J1939_ID_PRIO_SHIFT) & J1939_ID_PRIO_MASK;
> +}
> +
> +static inline int j1939_id_pgn(canid_t id)
> +{
> +	return (id >> J1939_ID_PGN_SHIFT) & J1939_PGN_MAX;
> +}
> +
> +static inline int j1939_id_pf(canid_t id)
> +{
> +	return J1939_PF(j1939_id_pgn(id));
> +}
> +
> +static inline int j1939_id_ps(canid_t id)
> +{
> +	return j1939_id_pgn(id) & UINT8_MAX;
> +}
> +
> +static inline int j1939_id_sa(canid_t id)
> +{
> +	return id & UINT8_MAX;
> +}
> +
> +/* Bytes in a 24-bit field of a TP or ETP control frame. */
> +#define J1939_LE24_LEN		3
> +
> +/*
> + * Byte offsets in TP and ETP frames (SAE J1939-21:2001 Figures 14 and 15,
> + * ISO 11783-6:2004 K.2.2.1 and K.2.3).
> + */
> +#define J1939_CM_CMD_OFF	0	/* control byte */
> +#define J1939_CM_PGN_OFF	5	/* message PGN, J1939_LE24_LEN bytes */
> +#define J1939_DT_SEQ_OFF	0	/* sequence number */
> +#define J1939_DT_DATA_OFF	1	/* first payload byte */
> +
> +/* Sizes and limits. */
> +#define J1939_SF_MAX_SIZE	CAN_MAX_DLEN	/* largest single frame */
> +/* payload bytes in one TP/ETP data (DT) frame */
> +#define J1939_DT_DATA_LEN	(CAN_MAX_DLEN - J1939_DT_DATA_OFF)
> +/* highest TP sequence number: the field is one byte */
> +#define J1939_DT_SEQ_MAX	UINT8_MAX
> +/* largest TP message; anything larger needs ETP */
> +#define J1939_TP_MAX_SIZE	(J1939_DT_SEQ_MAX * J1939_DT_DATA_LEN)
> +_Static_assert(J1939_TP_MAX_SIZE == 1785,
> +	       "SAE J1939-21:2001 section 5.10.1.1 gives 1785 bytes");
> +/* number of TP/ETP DT packets needed for len bytes, rounded up */
> +#define J1939_NUM_PKTS(len)	DIV_ROUND_UP(len, J1939_DT_DATA_LEN)
> +
> +/*
> + * J1939 uses 29-bit data frames only (no RTR, no error frames), see
> + * net/can/j1939/main.c.
> + */
> +static inline bool j1939_is_data_frame(canid_t can_id)
> +{
> +	return (can_id & (CAN_EFF_FLAG | CAN_RTR_FLAG | CAN_ERR_FLAG)) ==
> +	       CAN_EFF_FLAG;
> +}
> +
> +/*
> + * Size of a CAN_RAW receive buffer large enough for a full ETP burst.
> + * A round number with headroom, not a computed minimum. Set best-effort
> + * via SO_RCVBUFFORCE.
> + */
> +#define J1939_RAW_BIG_RCVBUF	(8 * 1024 * 1024)
> +
> +/* Flags for j1939_open_flags(). */
> +#define J1939_OPEN_NONE		0
> +#define J1939_OPEN_BCAST	0x1
> +
> +/* rcvbuf value for open_raw_rcvbuf(): keep the default receive buffer. */
> +#define J1939_RAW_RCVBUF_DEFAULT	0
> +
> +/* Set by j1939_test_main() from the CANIF environment variable. */
> +static char CANIF[IFNAMSIZ];
> +
> +/*
> + * Return relaxed_ms by default, or strict_ms if J1939_STRICT_TIMING is set in
> + * the environment. See "Timing modes" at the top of this file.
> + */
> +static inline int j1939_timing_ms(int relaxed_ms, int strict_ms)
> +{
> +	return getenv("J1939_STRICT_TIMING") ? strict_ms : relaxed_ms;
> +}
> +
> +/* Resolve the ifindex of the test interface named by CANIF. */
> +static inline int j1939_if_index(void)
> +{
> +	struct ifreq ifr = {};
> +	int s, idx = -1;
> +
> +	s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
> +	if (s < 0)
> +		return -1;
> +	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", CANIF);
> +	if (ioctl(s, SIOCGIFINDEX, &ifr) >= 0)
> +		idx = ifr.ifr_ifindex;
> +	close(s);
> +	return idx;
> +}
> +
> +/*
> + * FIXTURE_SETUP helper: resolve CANIF's ifindex into self->ifindex and abort
> + * the test if it cannot be found. Used as a statement:
> + * J1939_SETUP_IFINDEX(self);
> + */
> +#define J1939_SETUP_IFINDEX(self)					       \
> +	do {								       \
> +		(self)->ifindex = j1939_if_index();			       \
> +		ASSERT_GE((self)->ifindex, 0)				       \
> +			TH_LOG("failed to resolve ifindex for '%s': %d",       \
> +			       CANIF, errno);				       \
> +	} while (0)
> +
> +/*
> + * Open a J1939 socket bound to (name, sa, pgn); flags may set
> + * J1939_OPEN_BCAST.
> + */
> +static inline int j1939_open_flags(int ifindex, name_t name, uint8_t sa,
> +				   pgn_t pgn, int flags)
> +{
> +	struct sockaddr_can addr = {
> +		.can_family = AF_CAN,
> +		.can_ifindex = ifindex,
> +	};
> +	int s, one = 1;
> +
> +	s = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
> +	if (s < 0)
> +		return -1;
> +
> +	if ((flags & J1939_OPEN_BCAST) &&
> +	    setsockopt(s, SOL_SOCKET, SO_BROADCAST, &one, sizeof(one))) {
> +		close(s);
> +		return -1;
> +	}
> +
> +	addr.can_addr.j1939.name = name;
> +	addr.can_addr.j1939.addr = sa;
> +	addr.can_addr.j1939.pgn = pgn;
> +	if (bind(s, (struct sockaddr *)&addr, sizeof(addr))) {
> +		close(s);
> +		return -1;
> +	}
> +	return s;
> +}
> +
> +/* Open a J1939 socket bound to (sa, pgn) with no NAME and no broadcast. */
> +static inline int j1939_open(int ifindex, uint8_t sa, pgn_t pgn)
> +{
> +	return j1939_open_flags(ifindex, J1939_NO_NAME, sa, pgn,
> +				J1939_OPEN_NONE);
> +}
> +
> +/* Connect a J1939 socket to the peer (name, da, pgn). */
> +static inline bool j1939_connect_name_ok(int s, int ifindex, name_t name,
> +					 uint8_t da, pgn_t pgn)
> +{
> +	struct sockaddr_can addr = {
> +		.can_family = AF_CAN,
> +		.can_ifindex = ifindex,
> +	};
> +
> +	addr.can_addr.j1939.name = name;
> +	addr.can_addr.j1939.addr = da;
> +	addr.can_addr.j1939.pgn = pgn;
> +	return !connect(s, (struct sockaddr *)&addr, sizeof(addr));
> +}
> +
> +static inline bool j1939_connect_ok(int s, int ifindex, uint8_t da, pgn_t pgn)
> +{
> +	return j1939_connect_name_ok(s, ifindex, J1939_NO_NAME, da, pgn);
> +}
> +
> +/* Fill a sockaddr_can describing a J1939 (name, da, pgn) destination. */
> +static inline void j1939_fill_sockaddr(struct sockaddr_can *addr, int ifindex,
> +				       name_t name, uint8_t da, pgn_t pgn)
> +{
> +	memset(addr, 0, sizeof(*addr));
> +	addr->can_family = AF_CAN;
> +	addr->can_ifindex = ifindex;
> +	addr->can_addr.j1939.name = name;
> +	addr->can_addr.j1939.addr = da;
> +	addr->can_addr.j1939.pgn = pgn;
> +}
> +
> +/* sendto() len bytes from buf to the J1939 destination dst. */
> +static inline ssize_t j1939_sendto_addr(int s, const void *buf, size_t len,
> +					const struct sockaddr_can *dst)
> +{
> +	return sendto(s, buf, len, 0, (const struct sockaddr *)dst,
> +		      sizeof(*dst));
> +}
> +
> +/* sendto() len bytes from buf to the J1939 (name, da, pgn) destination. */
> +static inline ssize_t j1939_sendto(int s, const void *buf, size_t len,
> +				   int ifindex, name_t name, uint8_t da,
> +				   pgn_t pgn)
> +{
> +	struct sockaddr_can dst;
> +
> +	j1939_fill_sockaddr(&dst, ifindex, name, da, pgn);
> +	return j1939_sendto_addr(s, buf, len, &dst);
> +}
> +
> +/* One j1939_sendto() that sent all len bytes; no retry. */
> +static inline bool j1939_sendto_ok(int s, const void *buf, size_t len,
> +				   int ifindex, name_t name, uint8_t da,
> +				   pgn_t pgn)
> +{
> +	ssize_t want_len = len;
> +
> +	return j1939_sendto(s, buf, len, ifindex, name, da, pgn) == want_len;
> +}
> +
> +/* One send(), write() or read() that moved all len bytes; no retry. */
> +static inline bool send_all_ok(int s, const void *buf, size_t len)
> +{
> +	ssize_t want_len = len;
> +
> +	return send(s, buf, len, 0) == want_len;
> +}
> +
> +static inline bool write_all_ok(int fd, const void *buf, size_t len)
> +{
> +	ssize_t want_len = len;
> +
> +	return write(fd, buf, len) == want_len;
> +}
> +
> +static inline bool read_all_ok(int fd, void *buf, size_t len)
> +{
> +	ssize_t want_len = len;
> +
> +	return read(fd, buf, len) == want_len;
> +}
> +
> +/*
> + * Open a CAN_RAW socket on ifindex. Unless rcvbuf is J1939_RAW_RCVBUF_DEFAULT,
> + * request that SO_RCVBUFFORCE size (best-effort: a failure is logged, not
> + * fatal).
> + */
> +static inline int open_raw_rcvbuf(int ifindex, int rcvbuf)
> +{
> +	struct sockaddr_can addr = {
> +		.can_family = AF_CAN,
> +		.can_ifindex = ifindex,
> +	};
> +	int s;
> +
> +	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
> +	if (s < 0)
> +		return -1;
> +
> +	if (rcvbuf != J1939_RAW_RCVBUF_DEFAULT &&
> +	    setsockopt(s, SOL_SOCKET, SO_RCVBUFFORCE, &rcvbuf, sizeof(rcvbuf)))
> +		fprintf(stderr, "# %s: SO_RCVBUFFORCE(%d) failed: %d\n",
> +			__func__, rcvbuf, errno);
> +
> +	if (bind(s, (struct sockaddr *)&addr, sizeof(addr))) {
> +		close(s);
> +		return -1;
> +	}
> +	return s;
> +}
> +
> +static inline int open_raw(int ifindex)
> +{
> +	return open_raw_rcvbuf(ifindex, J1939_RAW_RCVBUF_DEFAULT);
> +}
> +
> +/*
> + * FIXTURE_SETUP helper: open a CAN_RAW socket on self->ifindex into self->raw
> + * with the given SO_RCVBUFFORCE size (or J1939_RAW_RCVBUF_DEFAULT) and abort
> + * the test if it cannot be opened. Used as a statement:
> + * J1939_SETUP_RAW(self, rcvbuf);
> + */
> +#define J1939_SETUP_RAW(self, rcvbuf)					       \
> +	do {								       \
> +		(self)->raw = open_raw_rcvbuf((self)->ifindex, (rcvbuf));      \
> +		ASSERT_GE((self)->raw, 0)				       \
> +			TH_LOG("failed to open raw socket: %d", errno);	       \
> +	} while (0)
> +
> +/* poll() + recv(): returns the recv() result, or -1 on timeout/error. */
> +static inline ssize_t recv_timeout(int s, void *buf, size_t len,
> +				   int timeout_ms)
> +{
> +	struct pollfd pfd = { .fd = s, .events = POLLIN };
> +
> +	if (poll(&pfd, 1, timeout_ms) <= 0)
> +		return -1;
> +	return recv(s, buf, len, 0);
> +}
> +
> +/*
> + * recvfrom() one message on s within timeout_ms, check that it is the len
> + * bytes in want, and return the sender in *src unless src is NULL. The buffer
> + * has one spare byte, so a longer message fails the check.
> + */
> +static inline bool recvfrom_verify_ok(int s, const void *want, size_t len,
> +				      int timeout_ms, struct sockaddr_can *src)
> +{
> +	struct pollfd pfd = { .fd = s, .events = POLLIN };
> +	socklen_t src_len = sizeof(*src);
> +	uint8_t *rx_buf = malloc(len + 1);
> +	ssize_t want_len = len, n = -1;
> +	bool ok;
> +
> +	if (!rx_buf)
> +		return false;
> +
> +	if (poll(&pfd, 1, timeout_ms) > 0)
> +		n = recvfrom(s, rx_buf, len + 1, 0, (struct sockaddr *)src,
> +			     &src_len);
> +	ok = n == want_len && !memcmp(want, rx_buf, len);
> +
> +	free(rx_buf);
> +	return ok;
> +}
> +
> +/* recvfrom_verify_ok() without the sender. */
> +static inline bool recv_verify_ok(int s, const void *want, size_t len,
> +				  int timeout_ms)
> +{
> +	return recvfrom_verify_ok(s, want, len, timeout_ms, NULL);
> +}
> +
> +/* Send len bytes on tx and verify they arrive byte-for-byte on rx. */
> +static inline bool send_recv_verify_ok(int tx, int rx, const void *buf,
> +				       size_t len, int timeout_ms)
> +{
> +	if (!send_all_ok(tx, buf, len))
> +		return false;
> +	return recv_verify_ok(rx, buf, len, timeout_ms);
> +}
> +
> +/* Receive one whole CAN frame from a raw socket within timeout_ms. */
> +static inline bool recv_frame_ok(int raw, struct can_frame *frame,
> +				 int timeout_ms)
> +{
> +	ssize_t want_len = sizeof(*frame);
> +
> +	return recv_timeout(raw, frame, sizeof(*frame), timeout_ms) == want_len;
> +}
> +
> +/* Encode a J1939 single frame the way the kernel does on transmit. */
> +static inline canid_t j1939_canid(uint8_t prio, pgn_t pgn, uint8_t da,
> +				  uint8_t sa)
> +{
> +	canid_t id = CAN_EFF_FLAG | (prio << J1939_ID_PRIO_SHIFT) |
> +		     (pgn << J1939_ID_PGN_SHIFT) | sa;
> +
> +	/* the destination goes into the PS byte of the PGN field */
> +	if (J1939_IS_PDU1(pgn))
> +		id |= da << J1939_ID_PGN_SHIFT;
> +	return id;
> +}
> +
> +/*
> + * Start a TP/ETP control frame: every byte J1939_FILL_BYTE, then the control
> + * byte cmd.
> + */
> +static inline void cm_dat_init(uint8_t *dat, uint8_t cmd)
> +{
> +	memset(dat, J1939_FILL_BYTE, CAN_MAX_DLEN);
> +	dat[J1939_CM_CMD_OFF] = cmd;
> +}
> +
> +/*
> + * Serialize a 64-bit NAME little-endian into a buffer of sizeof(name_t)
> + * bytes (host-agnostic).
> + */
> +static inline void put_name(uint8_t *dat, name_t name)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < sizeof(name); i++)
> +		dat[i] = name >> (CHAR_BIT * i);
> +}
> +
> +/* Little-endian codecs for the TP/ETP CM multi-byte fields (host-agnostic). */
> +static inline void put_le(uint8_t *p, uint32_t v, size_t n)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < n; i++)
> +		p[i] = v >> (CHAR_BIT * i);
> +}
> +
> +static inline uint32_t get_le(const uint8_t *p, size_t n)
> +{
> +	uint32_t v = 0;
> +	size_t i;
> +
> +	for (i = 0; i < n; i++) {
> +		uint32_t byte = p[i];
> +
> +		v |= byte << (CHAR_BIT * i);
> +	}
> +	return v;
> +}
> +
> +static inline void put_le16(uint8_t *p, uint16_t v)
> +{
> +	put_le(p, v, sizeof(v));
> +}
> +
> +static inline void put_le24(uint8_t *p, uint32_t v)
> +{
> +	put_le(p, v, J1939_LE24_LEN);
> +}
> +
> +static inline void put_le32(uint8_t *p, uint32_t v)
> +{
> +	put_le(p, v, sizeof(v));
> +}
> +
> +static inline uint16_t get_le16(const uint8_t *p)
> +{
> +	return get_le(p, sizeof(uint16_t));
> +}
> +
> +static inline uint32_t get_le24(const uint8_t *p)
> +{
> +	return get_le(p, J1939_LE24_LEN);
> +}
> +
> +static inline uint32_t get_le32(const uint8_t *p)
> +{
> +	return get_le(p, sizeof(uint32_t));
> +}
> +
> +/* Embed the PGN of the transported message into a TP/ETP control frame. */
> +static inline void put_pgn(uint8_t *dat, pgn_t pgn)
> +{
> +	put_le24(&dat[J1939_CM_PGN_OFF], pgn);
> +}
> +
> +/* Send one J1939-encoded frame of CAN_MAX_DLEN bytes with priority prio. */
> +static inline bool send_raw8_ok(int raw, uint8_t prio, pgn_t pgn, uint8_t da,
> +				uint8_t sa, const uint8_t dat[CAN_MAX_DLEN])
> +{
> +	struct can_frame f = {};
> +
> +	f.can_id = j1939_canid(prio, pgn, da, sa);
> +	f.can_dlc = CAN_MAX_DLEN;
> +	memcpy(f.data, dat, CAN_MAX_DLEN);
> +	return write_all_ok(raw, &f, sizeof(f));
> +}
> +
> +/*
> + * Payload bytes of the DT frame that starts at offset off of a message of
> + * size bytes; off must be below size.
> + */
> +static inline size_t j1939_dt_chunk_len(size_t size, size_t off)
> +{
> +	size_t n = size - off;
> +
> +	return n < J1939_DT_DATA_LEN ? n : J1939_DT_DATA_LEN;
> +}
> +
> +/*
> + * Send a TP/ETP data (DT) frame: sequence number seq and up to
> + * J1939_DT_DATA_LEN bytes from offset off of payload, a message of size
> + * bytes.
> + */
> +static inline bool send_dt_ok(int raw, uint8_t prio, pgn_t dt_pgn, uint8_t da,
> +			      uint8_t sa, uint8_t seq, const uint8_t *payload,
> +			      size_t off, size_t size)
> +{
> +	uint8_t dat[CAN_MAX_DLEN];
> +
> +	/*
> +	 * off >= size would make the size_t subtraction size - off
> +	 * underflow.
> +	 */
> +	if (off >= size)
> +		return false;
> +
> +	memset(dat, J1939_FILL_BYTE, sizeof(dat));
> +	dat[J1939_DT_SEQ_OFF] = seq;
> +	memcpy(&dat[J1939_DT_DATA_OFF], payload + off,
> +	       j1939_dt_chunk_len(size, off));
> +	return send_raw8_ok(raw, prio, dt_pgn, da, sa, dat);
> +}
> +
> +/* Milliseconds from a to b (negative if b is earlier), CLOCK_MONOTONIC. */
> +static inline long timespec_diff_ms(const struct timespec *a,
> +				    const struct timespec *b)
> +{
> +	return ((b->tv_sec - a->tv_sec) * NSEC_PER_SEC +
> +		(b->tv_nsec - a->tv_nsec)) / NSEC_PER_MSEC;
> +}
> +
> +/* Set *deadline to timeout_ms from now on CLOCK_MONOTONIC. */
> +static inline void deadline_after_ms(struct timespec *deadline, int timeout_ms)
> +{
> +	clock_gettime(CLOCK_MONOTONIC, deadline);
> +	deadline->tv_sec += timeout_ms / MSEC_PER_SEC;
> +	deadline->tv_nsec += (timeout_ms % MSEC_PER_SEC) * NSEC_PER_MSEC;
> +	if (deadline->tv_nsec >= NSEC_PER_SEC) {
> +		deadline->tv_sec++;
> +		deadline->tv_nsec -= NSEC_PER_SEC;
> +	}
> +}
> +
> +/*
> + * Poll and recv on raw until match() accepts a frame, or time out. match()
> + * gets the raw can_id; the j1939_id_*() decoders mask the flag bits. Other
> + * traffic must not extend the wait, so poll against a fixed deadline.
> + */
> +static inline bool recv_match_ok(int raw, int timeout_ms,
> +				 struct can_frame *frame,
> +				 bool (*match)(canid_t id, const void *ctx),
> +				 const void *ctx)
> +{
> +	struct pollfd pfd = { .fd = raw, .events = POLLIN };
> +	struct timespec now, deadline;
> +	int remaining = timeout_ms;
> +
> +	deadline_after_ms(&deadline, timeout_ms);
> +
> +	while (remaining > 0 && poll(&pfd, 1, remaining) > 0) {
> +		if (recv(raw, frame, sizeof(*frame), 0) < 0)
> +			return false;
> +		if (j1939_is_data_frame(frame->can_id) &&
> +		    match(frame->can_id, ctx))
> +			return true;
> +		clock_gettime(CLOCK_MONOTONIC, &now);
> +		remaining = timespec_diff_ms(&now, &deadline);
> +	}
> +	return false;
> +}
> +
> +struct j1939_peer_match { uint8_t want_pf, want_da, want_sa; };
> +
> +static inline bool match_peer_dest(canid_t id, const void *ctx)
> +{
> +	const struct j1939_peer_match *m = ctx;
> +
> +	return j1939_id_pf(id) == m->want_pf &&
> +	       j1939_id_ps(id) == m->want_da &&		/* destination */
> +	       j1939_id_sa(id) == m->want_sa;		/* source */
> +}
> +
> +/*
> + * Receive the next frame whose CAN-id PF == want_pf, sent from want_sa to
> + * want_da (PS).
> + */
> +static inline bool recv_for_peer_ok(int raw, uint8_t want_pf, uint8_t want_da,
> +				    uint8_t want_sa, struct can_frame *frame,
> +				    int timeout_ms)
> +{
> +	struct j1939_peer_match m = {
> +		.want_pf = want_pf, .want_da = want_da, .want_sa = want_sa,
> +	};
> +
> +	return recv_match_ok(raw, timeout_ms, frame, match_peer_dest, &m);
> +}
> +
> +/* recv_for_peer_ok() and check that the control byte is want_cmd. */
> +static inline bool recv_cm_cmd_ok(int raw, uint8_t want_pf, uint8_t want_da,
> +				  uint8_t want_sa, struct can_frame *frame,
> +				  int timeout_ms, uint8_t want_cmd)
> +{
> +	if (!recv_for_peer_ok(raw, want_pf, want_da, want_sa, frame,
> +			      timeout_ms))
> +		return false;
> +	return frame->data[J1939_CM_CMD_OFF] == want_cmd;
> +}
> +
> +/* Arbitrary; keeps fill_pattern() from being the plain byte offset. */
> +#define J1939_PATTERN_SEED	0x3c
> +
> +/*
> + * Fill buf with a deterministic, position-dependent byte pattern. The
> + * i >> CHAR_BIT term makes each 256-byte block differ, so a misplaced packet
> + * shows up.
> + */
> +static inline void fill_pattern(uint8_t *buf, size_t len)
> +{
> +	size_t i;
> +
> +	for (i = 0; i < len; i++)
> +		buf[i] = i ^ (i >> CHAR_BIT) ^ J1939_PATTERN_SEED;
> +}
> +
> +/* Is the CAN protocol proto missing from this kernel? */
> +static inline bool can_proto_missing(int type, int proto)
> +{
> +	int probe = socket(PF_CAN, type, proto);
> +
> +	if (probe < 0)
> +		return errno == EAFNOSUPPORT || errno == EPROTONOSUPPORT;
> +
> +	close(probe);
> +	return false;
> +}
> +
> +/*
> + * Body of each test's main(): require CANIF in the environment and a kernel
> + * that supports CAN_J1939 and CAN_RAW, then run the harness. Skip when any
> + * of them is missing.
> + */
> +static inline int j1939_test_main(int argc, char **argv)
> +{
> +	char *ifname = getenv("CANIF");
> +
> +	if (!ifname) {
> +		fprintf(stderr, "# CANIF must name the test interface\n");
> +		return KSFT_SKIP;
> +	}
> +	strncpy(CANIF, ifname, sizeof(CANIF) - 1);
> +
> +	if (can_proto_missing(SOCK_DGRAM, CAN_J1939) ||
> +	    can_proto_missing(SOCK_RAW, CAN_RAW))
> +		return KSFT_SKIP;
> +
> +	return test_harness_run(argc, argv);
> +}
> +
> +#endif /* __SELFTESTS_NET_CAN_J1939_TESTS_H__ */
>

[Severity: Low]
If the running kernel lacks CAN_J1939 or CAN_RAW, j1939_test_main()
returns KSFT_SKIP here without saying why. The CANIF check just above
prints a reason before it skips, but this path prints nothing.

j1939_run() in j1939_lib.sh passes only $J1939_TEST_PROG to
ret_set_ksft_status and relies on the binary to explain the skip. The
result is a log that shows the test as skipped with no hint that
CONFIG_CAN_J1939 or CONFIG_CAN_RAW is missing. That is awkward for
anyone triaging CI results.

Could you split the condition and print which protocol is unavailable?
For example, write a "# CAN_J1939 not supported by this kernel" line
to stderr, the same way the CANIF case does. The message could also go
into can_proto_missing() itself if you prefer that.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104-j1939-selftests-v2-0-cf797c83317b%40pengutronix.de
