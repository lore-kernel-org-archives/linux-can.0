Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C03A9856
	for <linux-can@vger.kernel.org>; Fri, 18 Sep 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789730109; cv=none; b=tD1hG099lS3H5y41EJYwkSLuQdtcBvbjNtyCPVWKKJD1H1T0yzf98LWbtDJ18W11191XaDGfBLHFjE/qn2L/FKUpkh2f2oxq+8ZWocL8anY+wjV8cNNmwOIzTV13Npg++Og3MvLNJISNyGTuBlECcjagZ2Y6q70y4FFaRxD8Dg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789730109; c=relaxed/simple;
	bh=ehQ6EL5eYKu3iSf1LH78bZZxbqgNpbez5eD6B71t0Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YWvmuMX1RP2GPMGCvFhDL2etmxi3U4RdDYAZaiJLGeutR2MTjorICIoe/aWoJwJzU1QTC5b3i6TQ6unSrJ2UFRAU1Yylg+752YWFEwzSX0gEe1Grmbja5EsBhogF3Cn1nUTc0f3PVdEuFX6tF3i6r+LAkXnVX8cceiaWJc/AzQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYUlOdam; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYUlOdam"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso6704085e9.1
        for <linux-can@vger.kernel.org>; Fri, 18 Sep 2026 04:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789730106; x=1790334906; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/bm1O88nJb7wxfnFbSkqPNAcj4aNu4XSJLtoBOXrheo=;
        b=lYUlOdamJaj/Z0XSy8C28CXqFCDXH3rkazCDat/Fk1BeOScz7XXVMwyNWW37VWAlpi
         e5YXLhZwp6+XEO60DwWhSJ2B6VUgecl5+CCAZSryg4thdplgPYKoFCbfrDN4ckq+5Azp
         XB260nlXp/eiV4OwjKdk+AePwE+sCMnSsI7tZPyGp0gnr5JDkUZ3/c87lAXMOvvxB+cw
         ru0WwghDN+MBC8R3C5/OPkh6KzPngMB2kTiKcCJMTkqPTuHyGQ/wvDtWhbj49tEemdHn
         8wheIvm7mUnWtBVbKLxVwsFZwYWph8ay29G8e93gjNWPweSw6dfz9IjLf1lQdPHECCD/
         kbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789730106; x=1790334906;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bm1O88nJb7wxfnFbSkqPNAcj4aNu4XSJLtoBOXrheo=;
        b=YvulEXrSyqHCGNbds/4IFPTrih5hStflRnomAQerwq5T8g6ouQcmV7SB8pSyS5lVyw
         1mrnKrHSUdukHEVHrkVcRroHSMEo7XzQAuDjDLPeLJGUBS7/tgHts7FHIZmnAg3fEUSK
         auBO50WZ1vngF7RkkmAvssj09be1MmIbdZpq4YFCZvW6gkPdNjsd4SX8OM3+GFXdHckA
         6KdD+RMll8bmN1z+LrqZjgfv++cnaPa0zTcV7ERPkW1LAT8O6Be8AwHy7kcft91smr3Q
         3q0RKMzXlGu+bWEnobltrxXUAu8FTgQdYRts9flg6uWE+monUeL6ys0a5UH/QQKqBDP9
         Id+g==
X-Forwarded-Encrypted: i=1; AKwUvBywIDAjC8DZyX63FE7BhzZTpfRB9GAJagtI9WT/v8LCAI4l/QM8d+obKLH4UlSUbShNrNxrRIz/8Ws=@vger.kernel.org
X-Gm-Message-State: AFuF++m7GToXAzbEx4kucVz5MrKK/O+aorB2ZQvOedKn4wnnao7hK0p0
	t3zVOosffWrYzKddjHH5c7ZUTuRFO4ODvR6kCLwzJ5mHnvTe9aT52n8DRlq2Mw==
X-Gm-Gg: AYBFou2tgo3b1rcRzN/V1hQZilEgZdSAhpSS2w/bhtm7er1wB7legzW3lhPg0v7nYRB
	kx9rK28QTiPZIfjzSarVeRHjXr7M228YKV4asz7KdFAjQSsk4hR/7JEHBDjl/wpzpv4nrKERkuR
	gf7JEi3n0mRUtpAap2h6G9FWF/04c2RB4zv2hB5XqSa7EcHysFpEEepuBXw8nBtrwod+jhLqjjV
	9KGiVNmAueyuWaHWO0EmjynnvrsLDLW4Vh8lgoP7ok7lga8omeP8TiLoRbX8YpvE0PkYNg8n1DT
	5emYtDzedLcRHfvoZHZj6vQNgMqs3Bya7Lrg3vCKQBEPX+S243+zW49mCnktjoLJkZdOs3ByjkV
	xL5VOdjkDL75QAUcWY+XIEIvcn3+MetVSQYdxjsPa3GUO8dtacQO6sUHK44PWmrlh2kuzqRPEI/
	DATtv/I0u1sjP+rCddHZVbI/qQ2WfaJZKWmoU0BY4k+ZamKcEuSBEW+L8xbVfqZ+Fmaxy5x+c0g
	wgVo9Lc0FeAXPOV+kRlnpYDqpMfDeZYtfBvc26R6f28TVArfSerIfad2cNMs/nk2PWev1Jfge8L
	LGsvfcr8JYTUF5qu0Rpm4m23Ca+yaYp8Mpvz2Sz/KQrxNL+cFt8O0EW5JH4YB1Bg+j0PWWvNhnL
	y2OcbmEBjDFCmcpjCsJmPN1+JqXL9FE6N3sKXVuO+hV+I4ivSGTc8l9QlzpruZ6P8ajcqUk6o6R
	fPi8q3
X-Received: by 2002:a05:600c:6610:b0:49f:bc28:e8bc with SMTP id 5b1f17b1804b1-49fc573576bmr24991795e9.17.1789730105827;
        Fri, 18 Sep 2026 04:15:05 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc7cfd1dasm46893545e9.9.2026.09.18.04.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 04:15:05 -0700 (PDT)
Date: Fri, 18 Sep 2026 13:15:04 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: "Markus Schneider-Pargmann" <msp@baylibre.com>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol"
 <mailhol@kernel.org>, <linux-can@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: pci: add missing
 pm_runtime_dont_use_autosuspend() call
Message-ID: <20260918131504.00005d2a@gmail.com>
In-Reply-To: <DLIC0I1VQLHE.13KVAJJ5FUYZN@baylibre.com>
References: <20260916124236.1389-1-joshua.crofts1@gmail.com>
	<DLIC0I1VQLHE.13KVAJJ5FUYZN@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 11:24:09 +0200
"Markus Schneider-Pargmann" <msp@baylibre.com> wrote:

> Hi Joshua,
> 
> On Wed Sep 16, 2026 at 2:42 PM CEST, Joshua Crofts wrote:
> > m_can_pci_remove() forgets to call pm_runtime_dont_use_autosuspend() on
> > teardown, even though autosuspend is enabled in m_can_pci_probe().
> >
> > Add the missing function call.
> >  
> 
> Can you please add a Fixes: tag?

I guess it's not a problem, however we had a discussion in the
USB subsystem whether this type of patch is a fix and ended up
agreeing that it's more hardening, hence no Fixes tag.

Alright if I just append the tag here for b4 to collect?

-- 
Kind regards,
Joshua Crofts
