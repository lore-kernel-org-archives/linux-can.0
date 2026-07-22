Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7AF3B3C10
	for <linux-can@vger.kernel.org>; Wed, 22 Jul 2026 04:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784696032; cv=none; b=tx/9SJEM8fF4XxbN9Tb3rzGOQ/Cf636h7+0IZQBKQ3G3gkD2kAO+5c9qW7XogogGu58i9epPEiojs3NV6LJhSSqeUep5eKtJO+X8RB1X7O8BF/G973L6esZdD2V6vVrkz1BD0BzS7xrEdFLI74nMhjJJ57CkyrMLUS/43/FRVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784696032; c=relaxed/simple;
	bh=uJEnJ82u2L2BDEvC2xOS4l/lMqH3lol+8VmeW/AbY4k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gYP9lRNzNiLGCsVFkxpIwAL2ZuC7sIbrSv1qDSwDlne2+q7+c2bqe28KGh4aa1NacX6/Ar4L7a9IdWyHyu4etd1nSIZy53NW3mIOp4gN8BpFpH7P2gsas6/xQGA4PO9YICBDSI65fGjSzSYEr9BiT6c3wgU7j7L0pDKhytedyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRV8OEmJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRV8OEmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104FB1F000E9;
	Wed, 22 Jul 2026 04:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784696031;
	bh=6XCWseU48Wm/AHR/miEUoiSYeo8BOxhPQhr2aj3deC0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LRV8OEmJperiifhJd1LPDqsDYJJCWasvfHgeo5Wgc01MudxDkkY8Svr9elJDETrHn
	 djaVUJevauQFL9pP0/oibJ4xkmNi1GNUqTonYeoI88ZuPdQp2LsYm7RXF/HHBX/0Dp
	 7UOltdJ1fjqjTdFp7whZ4DLs+dH7HQBKwAeFb8e53jvjYrtDUCYxDLQhcrUQdxqkf+
	 lznnFqxDjZVSedY/TVsHENEG3T9LT2YzOUaZNDu/bBjY6iqIOB198vIwxzHcKqgMA2
	 HSANR/HXYcsQLRrkKymrsSfSdMsk8+dxonbKyk05riWQ6qc/qcxnrHV3JgKahOlPHY
	 /Sa+XfLOhuNoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: softing: validate firmware record spans
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260722044347.2708-1-pengpeng@iscas.ac.cn>
References: <20260722044347.2708-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 04:53:50 +0000
Message-Id: <20260722045351.104FB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The firmware parser `fw_parse()` incorrectly uses `le16_to_cpup()`=
 and `le32_to_cpup()` to extract fields from a packed binary stream that is=
 typically unaligned.
- [High] The firmware loading functions silently return 0 (success) on fail=
ure paths when the firmware is missing an EOF or entrypoint record.
--

--- Patch [1]: [PATCH] can: softing: validate firmware record spans ---
commit 68a01b63a75d8a34f173d1c1f6e766add81e4a94
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: can: softing: validate firmware record spans

This commit adds bounds checking for firmware records parsed by fw_parse()
in the softing CAN driver. It validates that read operations do not exceed
the firmware blob and that DPRAM write operations fall within mapped memory
boundaries.

> diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/softi=
ng/softing_fw.c
> index 721df91cdbfbc..282570daf3efe 100644
> --- a/drivers/net/can/softing/softing_fw.c
> +++ b/drivers/net/can/softing/softing_fw.c

[ ... ]

> @@ -114,14 +114,21 @@ static int fw_parse(const uint8_t **pmem, uint16_t =
*ptype, uint32_t *paddr,
>  	 * endianness & alignment.
>  	 */
>  	mem =3D *pmem;
> +	/* A record needs an 8-byte prefix and a 2-byte checksum. */
> +	if (mem > limit || limit - mem < 10)
> +		return -EINVAL;
> +
>  	*ptype =3D le16_to_cpup((void *)&mem[0]);
>  	*paddr =3D le32_to_cpup((void *)&mem[2]);
>  	*plen =3D le16_to_cpup((void *)&mem[6]);

[Severity: High]
This isn't a bug introduced by this patch, but does fw_parse() incorrectly
use le16_to_cpup() and le32_to_cpup() to extract fields from a packed binary
stream that is typically unaligned?

The author explicitly commented that leXX_to_cpup() was chosen to solve
alignment, but these macros directly cast and dereference pointers, which
faults on unaligned addresses on strict-alignment architectures.

Should this use the safe <asm/unaligned.h> helpers like get_unaligned_le16()
instead here and when reading the trailing checksum below?

[ ... ]

> @@ -164,7 +172,7 @@ int softing_load_fw(const char *file, struct softing =
*card,
>  	}
>  	/* ok, we had a header */
>  	while (mem < end) {
> -		ret =3D fw_parse(&mem, &type, &addr, &len, &dat);
> +		ret =3D fw_parse(&mem, end, &type, &addr, &len, &dat);

[Severity: High]
This is a pre-existing issue, but do softing_load_fw() and=20
softing_load_app_fw() silently return 0 (success) on failure paths when
the firmware is missing an EOF or entrypoint record?

If the loop over the firmware records terminates normally because the
mandatory EOF or entrypoint is missing, the code subsequently triggers
a goto failed:

	if (!type_end)
		/* no end record seen */
		goto failed;

However, ret was set to 0 by the last successful fw_parse() loop=20
iteration. Since no negative error code (e.g., -EINVAL) is assigned
before jumping to the error label, does the function incorrectly return 0?

>  		if (ret < 0)
>  			goto failed;
>  		if (type =3D=3D 3) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722044347.2708=
-1-pengpeng@iscas.ac.cn?part=3D1
