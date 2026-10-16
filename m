Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18963451AA
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115647; cv=none; b=CqZXg/X5xA6kqua6TiFbVDEP4TxNBhLig7ggsIuzJqUnN/4qE8n019q3pLTbGi5jnEg82CQAl/Z1yWCEZlUisfOK3buZEGChZl+HFSPY+u8TaqtYQi1NTgcXKX2GCpXOVDbL/dg/LzFdBqdtLjVrj8g6KrfTvz/7ynQB5XeAxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115647; c=relaxed/simple;
	bh=qSoEyZpuTWGav8Wz12xyp1vvULlyL6fE7O5vbb4JhBk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=UaLD/czrrE9ceKZcMEtJdQYCONifnL0hD2YnfyNPY9xRNjmMeUZDmLrbPbzJOvk7rdaKk+G7b/9I/7x+2d1olL6k8209C4rMhGyNKKG+jcQWDnoKebaQwQY58uiHrU3sk/fNLNboSKga5Et0Ch0VUfZ/NEBaVllp+vHkoNDTPBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RDVsaHnx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RDVsaHnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C15F1F000C6;
	Fri, 16 Oct 2026 01:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792115645;
	bh=GpEXMfExBO3vCNpe7qyd9z1XcrL20fLyztBOe/2R4Vc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RDVsaHnxsunQj0Y8GI/yX8NXoto84HmFTvaidb7KH72Gn3KAPzzrkQaf3zlDSvHpF
	 AlhRn9del4gaW39lLxdr2PRbxN2iidui5siCFE10B3cLuJChMJ2YhGvzrVrqkAawzM
	 54/1rGGBmT6+Xyx5wwjJDsSz3KWxNs2/p0LkR6lwkZ5x/Vwy759VsIpwXyXk9Zt3iY
	 drhij2Bz7tbcuUUp61m67Ycg11UQ9Ctzb2j7bX4skHcjMcMQvLIT7MtMT+VicwMhdv
	 khPDVUQC3x6rBTJ3DjhDb2cxKS8pJUqv9KvpOD0M7m298pK1i9vCO2nISPGQ1HyjVg
	 7fhVBZ3i6vi2g==
Message-ID: <sashiko-outbox-173595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 33/37] can: kvaser_pciefd: fix use-after-free
 in bec poll timer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261015015336.816543-34-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
 <20261015015336.816543-34-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 01:54:04 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] can: kvaser_pciefd: missing SRB DMA engine shutdown in remove()
--

commit edee436281614056200b58c9acbef8d6681036cd
Author: Fan Wu <fanwu01@zju.edu.cn>

can: kvaser_pciefd: fix use-after-free in bec poll timer

This commit replaces timer_delete() with timer_shutdown_sync() in the device
removal and probe error paths. This ensures any running timer callbacks are
completed before the CAN devices are freed, preventing a use-after-free.

Link: https://patch.msgid.link/20260818063832.383829-1-fanwu01@zju.edu.cn

> diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers=
/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> index d8c9bfb202304..a0597db720864 100644
> --- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
> +++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
[ ... ]
> @@ -1879,7 +1880,7 @@ static void kvaser_pciefd_remove(struct pci_dev *pd=
ev)
>  		struct kvaser_pciefd_can *can =3D pcie->can[i];
> =20
>  		unregister_candev(can->can.dev);
> -		timer_delete(&can->bec_poll_timer);
> +		timer_shutdown_sync(&can->bec_poll_timer);
>  		kvaser_pciefd_pwm_stop(can);
>  		kvaser_pciefd_devlink_port_unregister(can);
>  	}

[Severity: Medium]
Could this teardown path leave the DMA engine actively running while
unmapping the device registers?

In kvaser_pciefd_probe(), the error path explicitly stops the DMA engine
before clearing the PCI master bit:

    err_teardown_can_ctrls:
        kvaser_pciefd_teardown_can_ctrls(pcie);
        iowrite32(0, KVASER_PCIEFD_SRB_ADDR(pcie) + KVASER_PCIEFD_SRB_CTRL_=
REG);
        pci_clear_master(pdev);

However, later in kvaser_pciefd_remove(), it proceeds directly to unmap
registers via pci_iounmap() and disable the PCI device without writing 0 to
KVASER_PCIEFD_SRB_CTRL_REG.

Does the SRB DMA engine need to be explicitly shut down here as well to
prevent PCIe AER errors or an inconsistent state across unbind/rebind cycle=
s?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015015336.8165=
43-1-mkl@pengutronix.de?part=3D33
