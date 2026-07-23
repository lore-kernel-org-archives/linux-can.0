Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C826C3DB324;
	Thu, 23 Jul 2026 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784802307; cv=none; b=SX9PvzBu6Vp14ePoj/c+zNhwupCve1hU1/XKv3cG/PfNqvxOvxQ6OWbYl11hyYECQjRHGopgMXGPAP0nChlWpuj1GSXTo/NDS3M4Val29YLxkWnWvtoP+QxFh1eU5U5FrKxaaUUYHMz/ISpEHIiUsrtx2LoLCSGjDm/oHR/sm20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784802307; c=relaxed/simple;
	bh=iqCKIoupZhFXbZHKR28WAKIJqgVO8VCU7zlM9Z0X19s=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Disposition:Message-Id:Content-Type; b=ZCmQhVfYS4F405H5jB/6+SfTznlv/CjbMEXH7psyIqLm5xb8SbxvT+Jb4Gyp7zHsmRDKHJQuYM4gaYZJqKNqe9//xPIHCGkTdNcN/Z/PjSowqrmEKVldlwFlJ+4LowOmEAfqeaOeX58Y/QSaN1skC3UXBss1Zcc+QNORlPhaukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=nqiILGvn; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="nqiILGvn"
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id BA995265F0;
	Thu, 23 Jul 2026 12:25:02 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id dZ6gEoudOKop; Thu, 23 Jul 2026 12:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1784802209;
	bh=LaDEtowLcAuaCbC05nT+2RrjTkmIoFZLlC5K9AP1o70=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=nqiILGvn/MA12fX84Qrgu74rlkXtkN81pkPhgIRqxQnNns46ztlthTebcSzq8krEQ
	 rUMLSnliYaUSCKb6vUFZfl5fmZhRecbcmbulvuj0CPrQAQDjtnSvbO69rDP97PAD88
	 UPZCttl8GmhJ2sDjv7qgzdyeTCMzRLJGNBvMGOE2VNg2jUUGyWx5NZpSMjIf6uI5U3
	 a1XjzSwC3w1c9uIOhLmKTjgqM60qk8Vt7ht7UiwzSeUGWkVBUhGsOo7yCM/4dDCq9j
	 0bnGXtVW8m7VeyIcy1yhgbo0v1VyZ9EYdHNpshczCAW1g288yjOsIYIyuhZpSORo2u
	 K295+Gk8RVgVw==
Received: from [147.32.86.199] (unknown [147.32.86.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id BFEA326556;
	Thu, 23 Jul 2026 12:23:28 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Avi Weiss <thnkslprpt@gmail.com>
Subject: Re: [PATCH net] can: ctucanfd: handle bus error interrupts
Date: Thu, 23 Jul 2026 12:23:28 +0200
User-Agent: KMail/1.9.10
Cc: linux-can@vger.kernel.org,
 Ondrej Ille <ondrej.ille@gmail.com>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol@kernel.org>,
 Martin Jerabek <martin.jerabek01@gmail.com>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jiri Novak <jnovak@fel.cvut.cz>
References: <20260723074403.131575-1-thnkslprpt@gmail.com>
In-Reply-To: <20260723074403.131575-1-thnkslprpt@gmail.com>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <202607231223.28272.pisa@fel.cvut.cz>
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello Avi,

thanks for correction.

On Thursday 23 of July 2026 09:44:03 Avi Weiss wrote:
> Include REG_INT_STAT_BEI in the top-level error interrupt condition.
>
> BEI is enabled when CAN_CTRLMODE_BERR_REPORTING is requested and
> ctucan_err_interrupt() already handles it. Without checking and
> clearing BEI in the top-level handler, bus error interrupts are not
> handled or acknowledged.
>
> Fixes: 2dcb8e8782d8 ("can: ctucanfd: add support for CTU CAN FD open-source
> IP core - bus independent part.") Signed-off-by: Avi Weiss
> <thnkslprpt@gmail.com>
> ---
>  drivers/net/can/ctucanfd/ctucanfd_base.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c
> b/drivers/net/can/ctucanfd/ctucanfd_base.c index 0ea1ff28dfce..0cd2d428c1f1
> 100644
> --- a/drivers/net/can/ctucanfd/ctucanfd_base.c
> +++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
> @@ -1136,8 +1136,12 @@ static irqreturn_t ctucan_interrupt(int irq, void
> *dev_id) /* Error interrupts */
>  		if (FIELD_GET(REG_INT_STAT_EWLI, isr) ||
>  		    FIELD_GET(REG_INT_STAT_FCSI, isr) ||
> -		    FIELD_GET(REG_INT_STAT_ALI, isr)) {
> -			icr = isr & (REG_INT_STAT_EWLI | REG_INT_STAT_FCSI | REG_INT_STAT_ALI);
> +		    FIELD_GET(REG_INT_STAT_ALI, isr) ||
> +		    FIELD_GET(REG_INT_STAT_BEI, isr)) {
> +			icr = isr & (REG_INT_STAT_EWLI |
> +				     REG_INT_STAT_FCSI |
> +				     REG_INT_STAT_ALI |
> +				     REG_INT_STAT_BEI);
>
>  			ctucan_netdev_dbg(ndev, "some ERR interrupt: clearing 0x%08x\n", icr);
>  			ctucan_write32(priv, CTUCANFD_INT_STAT, icr);

Acked-by: Pavel Pisa <pisa@fel.cvut.cz>


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
