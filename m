Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082072;
	b=kdZFsycR+Xq5B4910Mruj/IJBd+3SXbZb6RDn5tnCDzbCrlJDz0e2utuU24LhzErFNpw
	 gkedILuhdEywjksE0GlY+A2/dTaYNALziZ/amiC6l104D/U4utbb9bKBA3pxPw0ekMRn7
	 xAaMUmNwBXpJ9l+Cf8yTp2IFBSpif3LaD9/5kvEO5iTTtB/TXdakWGrAVbZG6fI7aD/KD
	 Z5iiSk8he8v9Rd+klp/Bt3zWP3hMygOz1pwIU7LDfmn3uzfzv9Gj2H94Sd5PC7r75WN3F
	 7X1jrcJlRjfstjg13UfOwsjIBQ+YHVcqRNtrwrOGqAHMrtAcCEKZd3AscSAazQLUTag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082072;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gZVA8ywCoKmS+/d31S2Dgx9UVZbLmCmiU0Ycu6ZMxds=;
	b=0HtjIreBCK6KhSreCuwY9RXAfWYtmst8olc/Y21xZifBzabgEkbPbuou7lKmyMndeOEY
	 psMgedkcjJ5r7O/kZ5Z5rU1AZhmqBzS2vfJnn0RkAalQFtGvffUW/ngqq9yebpZdj80xV
	 s48ypvFNoMVIm3PJVQFz2olwaFcDKsNM0yU/RSASMX9VRlGbo5Fk4gvWGuZdS8kiW0FPt
	 d5PZk6uxi0niXLd7ZUvyA0bLiIAjYVZdBwT2BPoH7wa7Kvuisx/APUcYoxJJjcC9IP1m9
	 bwnsiJIz9aGDaI/ZELUoXlf3zT1g/yXb41+ny2MIW2vTYLvvlyZpzNCiQ2ZJ7RZvC4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIDDhWH5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF09606A334;
	Thu, 19 Nov 2026 09:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIDDhWH5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F8151F000C5;
	Thu, 19 Nov 2026 09:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795082071;
	bh=gZVA8ywCoKmS+/d31S2Dgx9UVZbLmCmiU0Ycu6ZMxds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aIDDhWH56oARjS47tPdNxec0Z9ClYE9pCHHxf6kFDec2fiLOwaIzL5Ur/DUzBdPeP
	 R/6vIoKzusW4P3aq/gIlhNYn937wPVgcxUrk989It9Ms6EedIFXwOoXL1e6QlFAo6g
	 EBjfLzClBA9qXk+xsvaHJQQdHfYVobjBhgKCzg48JF112tadbiGhNXegNic0/OenTS
	 OByj1kuPrPwSx+EOYE4IfXk2CJXQ8qMiZRXQk1sjQ5o4oYsBewWw0dRiR557wO8NOq
	 Dk7xSiFtF8ABsH6NRQplasiqASLM0MiEp91iiAAdv3QbMRa4YCeAL/tfPTvljDkYfu
	 3odk6kOObbzCw==
Subject: Re: [PATCH net-next 08/12] can: janz-ican3: don't discard the IRQ
 lookup error in probe
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 dev.kurt@vandijck-laurijssen.be
Date: Thu, 19 Nov 2026 09:54:31 +0000
Message-ID: <179508207110.3136.11792101604636296316@kernel.org>
In-Reply-To: <20261118092955.1283165-9-mkl@pengutronix.de>
References: <20261118092955.1283165-9-mkl@pengutronix.de>
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

- [Low] The commit message doesn't say what users will see after the
  change, and the one failure that can actually happen is now reported…

--

can: janz-ican3: don't discard the IRQ lookup error in probe

This commit changes ican3_probe() to return the error from
platform_get_irq() as is, instead of always returning -ENODEV. The commit
message says the driver is an MFD child of janz-cmodio, cannot see
-EPROBE_DEFER, and should not invent its own error code.

Link: https://patch.msgid.link/28add8d0570b72d35c65c19b2365007cf0aa15c3.1792118040.git.chaosheng.qu.linux@gmail.com

> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
> index 1efdd1fd8caa4..a65326b0f11e9 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -1944,7 +1944,7 @@ static int ican3_probe(struct platform_device *pdev)
>  	/* find our IRQ number */
>  	mod->irq = platform_get_irq(pdev, 0);
>  	if (mod->irq < 0) {
> -		ret = -ENODEV;
> +		ret = mod->irq;
>  		goto out_free_ndev;
>  	}

[Severity: Low]
This isn't a bug, but could the commit message name the failure that can
actually happen here, and the new error code it produces?

The message says:

  The probe should not invent an error code for a lookup that failed for
  another reason.

cmodio_setup_subdevice() in drivers/mfd/janz-cmodio.c always gives each
child a single IRQ resource at offset 0:

	res->flags = IORESOURCE_IRQ;
	res->parent = NULL;
	res->start = 0;
	res->end = 0;

cmodio_probe_submodules() then passes the carrier PCI device's irq as
irq_base:

	return mfd_add_devices(&pdev->dev, 0, priv->cells,
			       num_probed, NULL, pdev->irq, NULL);

So the resource is always there, and the child has no OF node. On
non-SPARC systems, the only error platform_get_irq() can return here
appears to come from platform_get_irq_affinity() when the PCI device's
irq is 0:

	if (WARN(!ret, "0 is an invalid IRQ number\n"))
		return -EINVAL;

Before this patch, ican3_probe() turned that into -ENODEV. It now returns
-EINVAL.

In call_driver_probe() in drivers/base/dd.c, -ENODEV and -ENXIO are only
logged with dev_dbg ("rejects match"). -EINVAL goes to the default branch
and gets a dev_err ("probe with driver ... failed with error -22"). A
sysfs bind attempt would also get -EINVAL back instead of -ENODEV. On
SPARC the lookup returns -ENXIO, which is logged the same way as -ENODEV,
so nothing changes there.

The other patches in this series describe the visible change, for
example:

  A device tree without an interrupt now reports -ENXIO rather than
  -ENODEV

Could a similar note be added here, saying that -EINVAL now replaces
-ENODEV when the carrier's irq is 0? The code change itself looks correct.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261118092955.1283165-2-mkl%40pengutronix.de
