Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810240;
	b=Qtm53x7TJhFzGasb7AE+CtGdNO8LUh7dfgPkhTxK/kn4xPlPQ23kgQGbuoj/5FhUNvbj
	 fKXqrv44LRgdAKROkd6meWYX5Y0uLec48doF6RhWEUCBmZUU9mXEm86gNPsEbAOf2qzVb
	 XxAJaQaqUl18OCUOJ9RCK9HeyWCyvKf24NYYQ77qqc/nqvZiMDuXeFAqj1y3g8LBk+Z4V
	 8GYlqASLV+GZdU4RQDrV66FBO3l2W4Ri5ia87yyoMhOayWI2uj8G06U0FIzCpP7hIx6Xg
	 /+LLpVsj+aqqBMluFNyT4SK+RV1jw2QLljkTxAj01klATFTcfzzHR6eGunPIx6lSK5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sJXDBhtOJ+SyMPd0c6mGIJVtZsQKjkBCN5m/U/seib0=;
	b=A97JY5KXAUbC8kfTvgTQwbyM3EzsviVDEOMr+BE9ixanXhokIHTv0ufAQow/YKlw30Eu
	 8mxVGdMYkG9xjBeWLfMspFxy4StxzaWugF96en44riCbBZs2JsHb6pgrc5nkioKP+tXnr
	 lDntGVRPzNihm1Wjzy0qSiMZeNH7hsL0M9NpLDNe2Ce0Edl8d4jwuRUCu/EE4oD4J5HSY
	 ukJUtdA23oWpcBuz+CM5kG7/jARmMh6+XZTjyLcBcKEs3+towsD0w+DN5sVdSI0LOe8+Y
	 v09sLdwCN5hAoc/nt56Dkxr64lRKwBr+h8jPiGCo6gC8eMJMALidzNo1Zm89e598vLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3jlW9fh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE79B606A31B
	for <linux-can@vger.kernel.org>; Wed,  4 Nov 2026 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d3jlW9fh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359F51F00A15;
	Wed,  4 Nov 2026 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793810239;
	bh=sJXDBhtOJ+SyMPd0c6mGIJVtZsQKjkBCN5m/U/seib0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d3jlW9fhCQpwP1NcOjZv6zAm6/6ky7y6eHYGE1gvGIF/qUxaP5cqlG6tRdPWCm1+h
	 xYQ37dVmPo9l1zGYv5b/VLA+xgZ5VdDAtsy2zWiTAj5Ioih3rsef16HcrGMeAHgEQz
	 L/brmUpXQVaRN5Oe53kVLaOo1pXH4a09L0YQPdgiNx8OezOiBsmxc9xBRc8eH8tPRH
	 9fUZ7MgEedhskzKciePuzXHK8NNOZdesOF24ZNNgWGiPOGI/voJlf8NvEYBzpHx5Hd
	 4nYLrfaY5MfhcfWBQWE9pOaQsypUqQ9VPEHBtNFO8qJlO1Z0WJVh8IRXIVWQn0WHMF
	 3pCANDA2V/ENQ==
Message-ID: <sashiko-outbox-197631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v2 2/9] selftests: can: add J1939 test helper
 header and library
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oleksij Rempel" <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20261104-j1939-selftests-v2-2-cf797c83317b@pengutronix.de>
References: <20261104-j1939-selftests-v2-0-cf797c83317b@pengutronix.de>
 <20261104-j1939-selftests-v2-2-cf797c83317b@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:37:18 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests: can: silent skip in j1939_test_main() when protocol is m=
issing
--

commit f577ac7f70eba0a6d39e0839d07a59a287fefd8a
Author: Oleksij Rempel <o.rempel@pengutronix.de>

selftests: can: add J1939 test helper header and library

This commit adds j1939_tests.h and j1939_lib.sh to provide shared C
helpers and vcan setup/teardown logic for the J1939 selftests.

> diff --git a/tools/testing/selftests/net/can/j1939_tests.h b/tools/testin=
g/selftests/net/can/j1939_tests.h
> new file mode 100644
> index 0000000000000..78eb35f5b6b06
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/j1939_tests.h
> @@ -0,0 +1,724 @@

[ ... ]

> +/* Is the CAN protocol proto missing from this kernel? */
> +static inline bool can_proto_missing(int type, int proto)
> +{
> +	int probe =3D socket(PF_CAN, type, proto);
> +
> +	if (probe < 0)
> +		return errno =3D=3D EAFNOSUPPORT || errno =3D=3D EPROTONOSUPPORT;
> +
> +	close(probe);
> +	return false;
> +}
> +
> +/*
> + * Body of each test's main(): require CANIF in the environment and a ke=
rnel
> + * that supports CAN_J1939 and CAN_RAW, then run the harness. Skip when =
any
> + * of them is missing.
> + */
> +static inline int j1939_test_main(int argc, char **argv)
> +{
> +	char *ifname =3D getenv("CANIF");
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

[Severity: Low]
In tools/testing/selftests/net/can/j1939_tests.h, when can_proto_missing()
returns true because socket(PF_CAN, SOCK_DGRAM, CAN_J1939) or
socket(PF_CAN, SOCK_RAW, CAN_RAW) fails with EAFNOSUPPORT or
EPROTONOSUPPORT, j1939_test_main() returns KSFT_SKIP without printing why
the test was skipped.

Since j1939_run() in tools/testing/selftests/net/can/j1939_lib.sh only
passes J1939_TEST_PROG to ret_set_ksft_status on a skip exit code, could
j1939_test_main() print a message stating which protocol support is missing
(similar to the CANIF check right above it) so the skip reason is visible
in the test output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-j1939-self=
tests-v2-0-cf797c83317b@pengutronix.de?part=3D2
