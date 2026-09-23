Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B91D4457A9
	for <linux-can@vger.kernel.org>; Wed, 23 Sep 2026 07:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148282; cv=none; b=U6gQnKQ6H3Es9kUU0CfXexJFEz16w33GU/XhCDeMGbWr5DRHHNn6hB4QxPrk5AuBVIUBXmHdkAHDQH6rsrQQUInx6wGgJRSSajOQ1NEl/qOWW1A5j5ddEUC8xOJtgdNSDSk8mpD/Q1aIuNdEMCPaSv+/PiF2d5zD4/YAog7i6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148282; c=relaxed/simple;
	bh=jIfwlL6IpDoodjCU/e0KW6pY5aRNxKJ1LdDRRV7T+JM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ieyhQJEjAjh/f42WFzim02dB/d5OCEgac4sh4iiF7O8eB9X+GP959kEMeArMCd6xaegPIuiPkQWCWMdhm8TPAOuXaepMv7qzNWUn1fo86i5SdKOPMq1HNORpie4nNcQdtgIRC9EyhKd8x+1qIdDF5hyAnxitQZTAoi5LvSwwwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fhq/UvgQ; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fhq/UvgQ"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350faaso390713f8f.0
        for <linux-can@vger.kernel.org>; Wed, 23 Sep 2026 00:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790148279; x=1790753079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zljvdkg9X0EUgJ5j+rWAKWva+ugjDQMquvKTJ3Hi/KU=;
        b=Fhq/UvgQC0S2cG6vtdLL9/2dKWnH6y6k0D8fqyfZyEjF69SvbXu5wS1VW1G+n40LSn
         iSycZ1c6nLIec0CxbZ6yzcRp0o7M+oPss8B5A/4OFUtt8JyO6MoeqCz9YcRSNeagtO8g
         yey6+KKD+6oEH39ozZjvKEpYrZcPBsXEz6pLFgUb534+rIfvM+A568mSORhB0+chIFA5
         +Cm2Dn/ThkctDt8JJXcEM3oJTT+y0+VMvcBoMhGWHYIyip8pOnlyHZTyY5r0/vnEavSy
         oVppkDygNOb10saIFUbmT0cNi+/q/Br+rKlElO6g5toN3IYE/DShiWy9ntIcq85im0aB
         qoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790148279; x=1790753079;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zljvdkg9X0EUgJ5j+rWAKWva+ugjDQMquvKTJ3Hi/KU=;
        b=jfQ5Zqkr8zNxqdKLzSwT6micXUUhWzEWjNZQPjb5fBhzHi/+lx1st08uV32D64qeE/
         ZfSD/9sHQfubJDSFXWonjgI+pcnqjbR9tMyEUsQKUlXDQJQn/NecrFOjaTWDFT39R/R8
         KuOFUzjObUMZ9wFJYYQNkfnGU8ibw9V8G+Ugs0uNr9h2fYGwb6c8Jp/j/XnxefUGfWbL
         TTbxkrmY2sgadSVB2B/TGiBNfoKbOfMXwPj8zNka8VCu5yfqvWom3kuehi/t521S83zj
         yk3BA7sM7d7VzJ+UE/T7VedJzb1RiPqVM64dylaFxrrX5OXL9huRxAEJJv5NX51pjomy
         YtIg==
X-Forwarded-Encrypted: i=1; AKwUvBz13QuHscWmhGz0Nh512gozNsxmb3UvdKRAE59PsQMRi7Ih8JpZtyby86B68/xPnaz3mB1FzMZ5RQE=@vger.kernel.org
X-Gm-Message-State: AFuF++nIzX6aRKlJhqzCblSR9NOYiXIhHYTFILy4v7hBB0x4xoGuaDFc
	nzQ7/you6iVn97zHSuNC1ngARN2yg/ySsGHFhGfE1ZkLz48+FxW/+GCE
X-Gm-Gg: AYBFou2fxPlmFOdaUxMK2mIUxoMPdLjhIe171j5AMmaoxUvfLT9zCWOFv8BvzTZfbSJ
	adglFR/sGIN004a9RYOSPvRf+EE1iHVlYlW1vQvGjjMflibxaBD1FPWKyvfQ1yUpH9lIYlueorg
	f+f4CxA7VAiuMfVzHNhAwoW2QKM/9nHuWYdF7aUIk7X/UiCuPDs8hWEK5sfL6vATv1JfglVP+DJ
	wYp8wx+tvd5dCNSvUranef5opbHxWeCqpVM9cX1tfLCkNmYN/UbHyicYEIkIqCMQaU3Qp8rzFWP
	KvlHXgwa4gIvhQ50D8UFTAqPJO2xdO0E4dAqTpgg+ViLpAvMd7Me47wMBcgpBAA7ABH/4Osj0u/
	VzQlLf/YJ7IqUKizpUkIgmVoIIAZlBBhmuNgW95xFfC00x3ex84s70anVerjB3Gnrq08Ff3bRVY
	rkESgUobyyZfLSr5aQ9faCPQ8oP7uNdHUzdH5WEKj1g0IVC0ghrPLf9n4poO2nxkkGpiMBpZWnt
	hHsbC5eq5Ph7fzSneCeJegM6E7ciLgndsmBT3biekiZ4eqwT1YA7vaELUHn1JxCEvvJVdubsXQi
	rJxwucMicjcWhyoNVIyyrLA0rsTPtugrrYCvMIoA1uvFGinTokMMckQoaBQUdvQ0pt41Vdzyvli
	ZJMY0n1CFMgQyj4IaL6yNfJOb+cQWjPfDY2RMxvMKLmGBrHFAPRun+d4La2Q9gp3pjrWOGL+Ocv
	0o0RdK
X-Received: by 2002:a05:6000:4a0e:b0:487:8ec:1fc with SMTP id ffacd0b85a97d-488670493fdmr2579557f8f.12.1790148279173;
        Wed, 23 Sep 2026 00:24:39 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488684862a3sm4461373f8f.7.2026.09.23.00.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:24:39 -0700 (PDT)
Date: Wed, 23 Sep 2026 09:24:37 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol"
 <mailhol@kernel.org>, <linux-can@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: pci: add missing
 pm_runtime_dont_use_autosuspend() call
Message-ID: <20260923092437.00006b61@gmail.com>
In-Reply-To: <DLMI87KFXHTQ.SWLSTWGCM2T4@baylibre.com>
References: <20260916124236.1389-1-joshua.crofts1@gmail.com>
	<DLIC0I1VQLHE.13KVAJJ5FUYZN@baylibre.com>
	<20260918131504.00005d2a@gmail.com>
	<DLMI87KFXHTQ.SWLSTWGCM2T4@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 09:06:59 +0200
"Markus Schneider-Pargmann" <msp@baylibre.com> wrote:

> On Fri Sep 18, 2026 at 1:15 PM CEST, Joshua Crofts wrote:
> > On Fri, 18 Sep 2026 11:24:09 +0200
> > "Markus Schneider-Pargmann" <msp@baylibre.com> wrote:
> >  
> >> Hi Joshua,
> >> 
> >> On Wed Sep 16, 2026 at 2:42 PM CEST, Joshua Crofts wrote:  
> >> > m_can_pci_remove() forgets to call pm_runtime_dont_use_autosuspend() on
> >> > teardown, even though autosuspend is enabled in m_can_pci_probe().
> >> >
> >> > Add the missing function call.
> >> >    
> >> 
> >> Can you please add a Fixes: tag?  
> >
> > I guess it's not a problem, however we had a discussion in the
> > USB subsystem whether this type of patch is a fix and ended up
> > agreeing that it's more hardening, hence no Fixes tag.
> >
> > Alright if I just append the tag here for b4 to collect?  
> 
> Yes, that's ok for me.
> 

Fixes: cab7ffc0324f ("can: m_can: add PCI glue driver for Intel Elkhart Lake")

-- 
Kind regards,
Joshua Crofts
