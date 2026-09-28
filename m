Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743164AA1C3
	for <linux-can@vger.kernel.org>; Mon, 28 Sep 2026 11:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595317; cv=none; b=TJX99xz9OewiJfQNZ/rEdJ2yMD8a6JmTATViaKySgNAQcy+G4/VYmBBTFVSU5SZRIyVhSnkEWTf8BVyWIJPDSRj3iMp2IbcX84ekMYily0dt4AF9PwjScVAnQhyAnFaCfPBQLcyD3J/MwmMQiKX+R8p1YTH/4mvAGqCyUtionvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595317; c=relaxed/simple;
	bh=Gi5zACnJc/3ULH13LfNFDZC7kieZQ2f5C8BnB/jPw/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dEtidgCfHpNaVbArEyEwTuxd1PVTlzqFLLBBtIWRTx70PoeJfrt2if5OLBkGdTYBrlBrkA31Iv3C1IYZKS0mKVNH4iCELuZOU1w7o5aqwURlbF2J/3o45ADMRFqlRdPttz/cEz3e/SEmGHP09x+0eJ/kYFLXX16dwPNNBSWRoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOA1Z4J4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOA1Z4J4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0212B1F000FF;
	Mon, 28 Sep 2026 11:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790595315;
	bh=XwER1SDQCI7yxTtcZp4gdUrNRTkKocJ/I+WeOXBi9FM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FOA1Z4J4/H4ZE/qjxbqQzFwVjWsODW3SwGYwxP2tAyU1502Dqn9lmUslwcdO+p6WT
	 P4fpe7LsI+7vWRO+8RcG/9k3SyNprlIROJF/EfOizNcPqXXtj17pAMP64jWBWf5q6S
	 Ovfjm3dJC8qRHNPfuCeUy47F7D42LjjXIlVMW07o0Wgq3GVUgemY/rtaJBRnc/jz7L
	 L+bKTIyjKirdvJsQODGABdZ4Uu5X2sF3bzTKxs8rNcJc/l8GD2dpkT0HY1NxyEn/J3
	 3xJE2t8R7haOibiuXGez+hlCQ6bk8AhrQPG5svf/fwfF0u1EqLfgh2Rlp7Sl1GGG7v
	 OIYjnkRILIoXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests: can: add isotp frame-type tests
Reply-To: sashiko-reviews@lists.linux.dev
To: Quchaosheng <quchaosheng000406@163.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260928112720.2120220-1-quchaosheng000406@163.com>
References: <20260928112720.2120220-1-quchaosheng000406@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 11:35:14 +0000
Message-Id: <20260928113515.0212B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: unconditional cleanup destroys pre-existing interfaces
--

commit ffa7302bd0c4a8a610bf89cdbd13b8881574eec4
Author: Quchaosheng <quchaosheng000406@163.com>
   =20
selftests: can: add isotp frame-type tests
   =20
This commit adds a suite of tests for the isotp socket frame-type
handling, ensuring that Classic CAN and CAN FD channels correctly separate
frames by channel characteristics without incorrectly identifying CAN XL
frames.

> diff --git a/tools/testing/selftests/net/can/test_isotp_frame_type.sh b/t=
ools/testing/selftests/net/can/test_isotp_frame_type.sh
> new file mode 100755
> index 0000000000000..1ee28ff3108ba
> --- /dev/null
> +++ b/tools/testing/selftests/net/can/test_isotp_frame_type.sh
[ ... ]
> +setup()
> +{
> +	if [[ $CANIF =3D=3D vcan* ]]; then
> +		ip link add name $CANIF type vcan || exit $ksft_skip

[Severity: Medium]
If the vcan interface already exists, ip link add will fail, causing the
script to exit. Since the trap for the cleanup function is registered before
setup is called, won't this trigger the cleanup function and tear down the
user's pre-existing interface?

> +		# a vcan device defaults to CANXL_MTU, so it carries every frame
> +		# type this test needs without further configuration
> +		ip link set dev $CANIF mtu 2060 2>/dev/null
> +	else
> +		echo "test_isotp_frame_type requires a vcan device" >&2
> +		exit $ksft_skip

[Severity: Medium]
If a user runs this test with a non-vcan interface, the setup function
will exit and skip. Does this also trigger the unconditional cleanup on
the user's provided interface?

> +	fi
> +	ip link set dev $CANIF up
> +}
> +
> +cleanup()
> +{
> +	ip link set dev $CANIF down
> +	if [[ $CANIF =3D=3D vcan* ]]; then
> +		ip link delete $CANIF
> +	fi
> +}

[Severity: Medium]
Can this unconditionally destroy host network interfaces?

Because setup can fail or skip after the exit trap is registered, this
cleanup function executes unconditionally. It looks like this will bring do=
wn
and potentially delete active host interfaces that the test itself never
created.

Should the script track whether it actually created the interface before
attempting to modify its state or delete it?

[ ... ]
> +trap cleanup EXIT
> +setup
> +
> +tests_run
> +
> +exit $EXIT_STATUS

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928112720.2120=
220-1-quchaosheng000406@163.com?part=3D1
