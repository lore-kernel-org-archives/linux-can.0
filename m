Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AE13F12C4;
	Mon, 24 Aug 2026 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562909; cv=none; b=EREUTsAywQBUH3Kle1Wqkas3Q8qH8gmrBA+qM8z5I0JR+BYtXrGGZ4KiwfPYFzNRRX4ra7bmOaMK0+e/UrbuUc6fhvFtEu/0T3tj4xN0gPTi4L47XUJM8Vis48PVyqIL9Z3rGJQMXWl3H62mlRHg2p1SFWOYek/VGosVZ+rgbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562909; c=relaxed/simple;
	bh=/VAlzpsOFvTEr4V/kawfjFo1pm2ftQS+N4SsjtDhRaI=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=OmfYgW2EGNtDt2lBV88awB/yibwlZINC5ct4glBlL8Cg2SKOr55OzqJ0Qiotp/zGl016rGn8l6qtBBKaGy+uL2tAnCLvJNHpCZKeiz2/EHs3YrgdN13aVHKxbeHOXk+xc9SReU/+eNB/StsXyTTnGR+lGIMa880Inw442lKZcpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=TN2uRTdu; arc=none smtp.client-ip=147.32.210.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="TN2uRTdu"
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id A588024E42;
	Mon, 24 Aug 2026 11:05:25 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: cerokez-250.feld.cvut.cz (amavis);
 dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id vIjbhkWAe2xb; Mon, 24 Aug 2026 11:05:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1787562324;
	bh=0A8sVhPDx6u5+aFDevt2uo+o3yVl789Ty5qY4ZXnS5g=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=TN2uRTdulu6Dfw1xnDbwrPmQHQTtA0mXQKgAgEpo402btMMUdbF6JQOI0wFj0zFVj
	 lOlI12FKBL1ucvwobzCNLJtyx+DG6UMPONIvMKGqhJXg2kivTDhjDnM3iu7rSyUUgK
	 5fVoaASiunKNNKUEXw8OLLcVY8ol36ZUt12xzBCaJwqyw4vpaynC9A00Wt7Jf0Ni6T
	 d6KlV8VdBvgCzsOTLddloDqwFnIBpX/eYHyeUn4P6N2mKBH626cgqY7UgS9u+xKPO5
	 nf3uuQohUBqGWGOUy7TIaSTs0DcJAtFib2i8wJLPRNrWBBF1YKhbv8Jr9xsiHppSCk
	 AH3HqLHfSS1xg==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 0756B24E41;
	Mon, 24 Aug 2026 11:05:23 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Subject: Re: LinuxDays 2026 October 3 and 4 in Prague was: can: ctucanfd: ctucan_err_interrupt()
Date: Mon, 24 Aug 2026 11:05:23 +0200
User-Agent: KMail/1.9.10
Cc: Ondrej Ille <ondrej.ille@gmail.com>,
 Vincent Mailhol <mailhol@kernel.org>,
 Avi Weiss <thnkslprpt@gmail.com>,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 kernel@pengutronix.de,
 Jiri Novak <jnovak@fel.cvut.cz>
References: <20260806-ctucanfd-silence-can-bus-error-messages-v1-1-70eff67debfd@pengutronix.de> <202608150102.34461.pisa@fel.cvut.cz> <20260818-optimistic-woodlouse-of-cookies-972baa-mkl@pengutronix.de>
In-Reply-To: <20260818-optimistic-woodlouse-of-cookies-972baa-mkl@pengutronix.de>
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
Message-Id: <202608241105.23402.pisa@fel.cvut.cz>

Hello Marc and others,

and thanks for support of our HW as well as CAN and Linux
in general.

On Tuesday 18 of August 2026 11:54:01 Marc Kleine-Budde wrote:
> On 15.08.2026 01:02:34, Pavel Pisa wrote:
...
> > Anyway if you have interest to meet,
> > I will be in Prague and when not teaching, I will be happy to
> > reserve time. There would be real local enthusiast, free community
> > and access conference before these Linux Foundation ones
> >
> > https://www.linuxdays.cz/2026/
> >
> > I expect to show our HW ZOO there on the booth there as usual
> > so you can visit us at our university ground.
>
> I will arrive on Sunday, but I haven't booked a train yet. When does the
> conference close on Sunday?

For this year, the program is not finalized yet, but the closing
session was on Sunday at 16:00 last year. The LinuxDays conference

  https://www.linuxdays.cz/

has a majority of talks in the Czech language (it is mainly local event).
Still, some are in English, and it is a place where a lot of local
hackerspaces and other groups (often including SUSE, Fedora, etc)
present projects. Sometimes, even advanced ones like 400G Traffic
Monitoring FPGA hardware by CESNET, some links are there

  https://ieeexplore.ieee.org/document/10035175
  https://github.com/CESNET/ndk-fpga
  https://github.com/CESNET/ipfixprobe

usually lot of embedded HW, Linux based,
retro HW etc.
   
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
