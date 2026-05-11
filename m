Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B34255F52
	for <linux-can@vger.kernel.org>; Mon, 11 May 2026 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778473321; cv=none; b=aF9HTch83UqGGw7JJYzDduOskvc/mDJdtXX5YIgFqwAtvHSgnwsl+ogGORfc4rNbnpR9cBmaxDJp37QivvUpIHfHjyCRDmVGgsNB1C+t1SSTnYMo9Nko2z31XNNz+ltrvPJZTIv0kgES/UPEtm0qpJL3BNnuSq9JGa37hLJkzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778473321; c=relaxed/simple;
	bh=AvACyM2byGdXQEHQnoVFjO4v9Ms6Q+3e10gracPHV8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDPP694bSLz/lUZNCfSqZxdSH8q+yCVMXVrB8Eo77ZgUzOj+zF05g+YoLaNw67BUwyrrd/lvtxllUdWrMnP/1dND0F3IUvFo8j7x0K2dRMugsjyAoHZQOtmlhiqEp3JmoSUg+TGyvfcXxgf6ZK1IBexQPCsy2uAYFfGY9pidQaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wMI9J-0002gh-Ah; Mon, 11 May 2026 06:21:45 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wMI9H-000Byt-1i;
	Mon, 11 May 2026 06:21:44 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wMI9I-0000000F7aH-0W2c;
	Mon, 11 May 2026 06:21:44 +0200
Date: Mon, 11 May 2026 06:21:44 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Breno Leitao <leitao@debian.org>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/2] can: j1939: convert to getsockopt_iter
Message-ID: <agFZWFwyTJGrLqKH@pengutronix.de>
References: <20260507-getsock_two_can-v1-0-3c2ae9edfadc@debian.org>
 <20260507-getsock_two_can-v1-1-3c2ae9edfadc@debian.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-getsock_two_can-v1-1-3c2ae9edfadc@debian.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

On Thu, May 07, 2026 at 02:34:47AM -0700, Breno Leitao wrote:
> Convert CAN J1939 socket's getsockopt implementation to use the new
> getsockopt_iter callback with sockopt_t.
> 
> Key changes:
> - Replace (char __user *optval, int __user *optlen) with sockopt_t *opt
> - Use opt->optlen for buffer length (input) and returned size (output)
> - Use copy_to_iter() instead of copy_to_user()
> - Restructure the chained if/else if (which depended on put_user() being
>   an expression) into a nested if/else block now that opt->optlen = len
>   is a statement
> - Add linux/uio.h for copy_to_iter()
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

LGTM, Thank you!

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
