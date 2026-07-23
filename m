Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48B34107F;
	Thu, 23 Jul 2026 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798607; cv=none; b=mTyPp0zkcJ+TKM6lWhTnKjWk350P3rEsPs6mSM7Sh3AHtBZb0NU8EX4l643etK9bh31IS2JIxOPDOMRO8sEahSsBBKzd8auZeygviqZb5Sfl6LhjcS6t6JtHU56WVt1C7CiI+ZqDkaiuwbS67VLtdrBjgMrc0fgO0HBlsqcYoKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798607; c=relaxed/simple;
	bh=iqCKIoupZhFXbZHKR28WAKIJqgVO8VCU7zlM9Z0X19s=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=l7lhqSngABsFvF1kMny4VVdkF8AHBreqSYclqY5uyRgzlTRNdbW86NaYckkK0Eo1r8fr7OBfIK+bi2WfnTRu4kjLl0Q7M2xZPiRZt1ygWfzimMtO5+0AwTOuRgffY9EWXcTEmULMF5IG/c0NwOM5lesgMVJ7qKFo2VdIgVija7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cmp.felk.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cmp.felk.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id ED26026681;
	Thu, 23 Jul 2026 11:23:18 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id gQiO1c-qikRB; Thu, 23 Jul 2026 11:23:17 +0200 (CEST)
Received: from [147.32.86.199] (unknown [147.32.86.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 08E8426338;
	Thu, 23 Jul 2026 11:23:17 +0200 (CEST)
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Avi Weiss <thnkslprpt@gmail.com>
Subject: Re: [PATCH net] can: ctucanfd: handle bus error interrupts
Date: Thu, 23 Jul 2026 11:23:16 +0200
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
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202607231123.16662.pisa@cmp.felk.cvut.cz>

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
