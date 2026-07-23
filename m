Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A27B40B115;
	Thu, 23 Jul 2026 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801857; cv=none; b=TEwS+Ev3cOfuO1kmEmBK93e4vJDk/CzYhyIIBD8cflEQ6iu/KseMzMf4V0v1ws8sv17T7WhnLd3NQWjGwiXLKQvmLqi6Yfe3lY2Re+TdpdyDhiu/9yy4WEeWB1h+fKgAfn3s2kq7L4U9+ms1s4tPcvN2691CtX/4yfcLn5er3VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801857; c=relaxed/simple;
	bh=IMyHJ1uCYih5VupCBflOXNUl9xjAdtK0OfsHz3oABDw=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=lHGx1DbuhNuzIyysnnXrsu/pgMQHt/NIz2c5qVMPNEWo5u6WbNroSBj46P/LVAdwbvQ+hvzkr8l1z0oHlN0oc6v8nIpnoPljEJ/ncrYONXKiyL3k8swA3500CcmKAR78e1cHFN5TyauhWn6imxf3HdL5rMTX9cMua3ANeamxu4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=PjgLa8uI; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="PjgLa8uI"
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 386D32673A;
	Thu, 23 Jul 2026 12:17:32 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id 8UcYJU-EzeEI; Thu, 23 Jul 2026 12:17:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1784801850;
	bh=vx1PC/Q+ixT2juZRzVWK5XW8N1zhU5lePLgiFnqWY2Q=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=PjgLa8uIk7Pls5pNygNdUNNz/1lIAHUz+4y0eNQGRPls5zjODlzPWx06Ye53ujLjG
	 aYGPi6pAesNnoCLUHq3Xar0Qx+n0W8gwBxn3YfljuRl8yt3RtqVEbRljpOHCMdGhNt
	 S5+bZ2DvP2RHyzkWd+tB5uFv0BfamMimyTCkQszv9xy1FbsCwDCBlJszRuYRlN0inh
	 +jFANgarwSb//dswhZ06d1WGlJYArYPJCoMZInRyhIEk1D5xiyBz6Mn3rtYRH+bfYB
	 m/30XZE8hTaM7xqvmXK9ofmfxBVennm1XFgcrNzrVNQKUnaoPBZCeBdt9BFffPbH/p
	 c7DSBjT+BoW4w==
Received: from [147.32.86.199] (unknown [147.32.86.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 3D093264DE;
	Thu, 23 Jul 2026 12:17:29 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Avi Weiss <thnkslprpt@gmail.com>
Subject: Re: [PATCH net] can: ctucanfd: unmap BAR0 using base address
Date: Thu, 23 Jul 2026 12:17:28 +0200
User-Agent: KMail/1.9.10
Cc: linux-can@vger.kernel.org,
 Ondrej Ille <ondrej.ille@gmail.com>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Martin Jerabek <martin.jerabek01@gmail.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260723095934.181042-1-thnkslprpt@gmail.com>
In-Reply-To: <20260723095934.181042-1-thnkslprpt@gmail.com>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202607231217.28574.pisa@fel.cvut.cz>

Hello Avi,

thanks for correction.

On Thursday 23 of July 2026 11:59:34 Avi Weiss wrote:
> BAR0 is mapped into bar0_base, while cra_addr points to an offset
> within that mapping and is used for other purposes.
>
> Pass bar0_base to pci_iounmap(), instead of cra_addr, on the probe error
> path so the address returned by pci_iomap() is used for unmapping.
>
> Fixes: 792a5b678e81 ("can: ctucanfd: CTU CAN FD open-source IP core - PCI
> bus support.") Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
>  drivers/net/can/ctucanfd/ctucanfd_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/ctucanfd/ctucanfd_pci.c
> b/drivers/net/can/ctucanfd/ctucanfd_pci.c index 625788fa8976..f845951c5d51
> 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_pci.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_pci.c
> @@ -194,7 +194,7 @@ static int ctucan_pci_probe(struct pci_dev *pdev,
>  	pci_set_drvdata(pdev, NULL);
>  	kfree(bdata);
>  err_pci_iounmap_bar0:
> -	pci_iounmap(pdev, cra_addr);
> +	pci_iounmap(pdev, bar0_base);
>  err_pci_iounmap_bar1:
>  	pci_iounmap(pdev, addr);
>  err_release_regions:

Acked-by: Pavel Pisa <pisa@fel.cvut.cz>

CRA has been on the start in initial PCIe integrated
version and when it has been shifted the switch
of the name has been done incorrectly for pci_iounmap

Best wishes,

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home
