Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27F0411F8D;
	Thu, 13 Aug 2026 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786602597; cv=none; b=Gekcueg+Bd3ypdZ4OBf5gLyPXD+0//4l8TdSYgT2e2CsmAiw9syX+CTmnmVWwnyXDUb1copYgM/NLfgxr+ikuOYADF9VsSBfVp95Al5lVXLHBmmYdTQSk2DiJqc2Vz03uJPonlwTWJbuUy0mFE14JSQCdEED9GPPS8+13S+npWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786602597; c=relaxed/simple;
	bh=TAw0zEN+ks++dfKGePCUTj2CnfJxDSpmI34j7HBNcoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAwmMQdi/W87B8+ZTe/8rvk0g6VUBzyYLu4QEp35DVdObC+t6rl0jtqD2j3W8S+3VnWtagcQG/1GhrnP+oLMRzRaxH7BsRkPcXYptghpQrQZlhlxLZSHZXbC3h8sSCJoQwtbT0u11uFvp7dHQh9YRpjr7S6MvoAikgqr5ZTrP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 33FE12006E0;
	Thu, 13 Aug 2026 08:29:52 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wuOwq-001Ewh-0Q;
	Thu, 13 Aug 2026 08:29:52 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wuOwq-0000000GWEQ-05u3;
	Thu, 13 Aug 2026 08:29:52 +0200
Date: Thu, 13 Aug 2026 08:29:51 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Xiang Mei <xmei5@asu.edu>
Cc: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de,
	linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
	bestswngs@gmail.com
Subject: Re: [PATCH net] can: j1939: zero the reassembly buffer to avoid
 uninitialized slab leak
Message-ID: <an1kX7DUTYsRSGAo@pengutronix.de>
References: <20260706011131.2445034-1-xmei5@asu.edu>
 <CAPpSM+Sn2vOg3xQBBRBvt8m-cvW5-f27xPL=N32yiwT5Nqb0Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPpSM+Sn2vOg3xQBBRBvt8m-cvW5-f27xPL=N32yiwT5Nqb0Jw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Xiang Mei,

On Wed, Aug 12, 2026 at 04:57:45PM -0700, Xiang Mei wrote:
> Hi maintainers,
> 
> Just a reminder to avoid spending time on this. A recent commit fixes
> this issue:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eb96c5890792

Thank you for your feedback!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
