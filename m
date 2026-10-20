Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504435;
	b=lbTYJD/ke7YCre8nQQnpYS/GLVzwWdRhqjTk5nuM/ZTRgkkQ2ZiCLZvc1NU0Wzr+487C
	 FoRbqbV6EyhJeZiyWueD9w7hHWUt8vwWps/641OYXAFa0p7ILfc/DdRULsk+PH0VugAt6
	 /1G3Jb9MddeOePttRthgzYnwQJtAzT7XffssO+qOyPkXF7uiX6GnWRFgv7Psr/3hX64I/
	 cAzdXlOL2p7B91WzAAqfnlUcPRFxo5Bu/93X1rixcHdGmV6FB68cFqFYq+2Wn6fH9/pr3
	 VZMjRZ2eg6ETMNC+tzKhkHg2c8hQirDiD6KHs1i4RcRc2e+oaYEzuZLLZVKyZpGsZbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=F4S/z3wLn6j43Kaqn3bJJAq9gOmklL0Dy1KFsPWVhCQ=;
	b=v3Nw80SGmOFHfk7VvBs/tLfiJDG5pl+XT1JFQJrMa0clCw+PIQ4P2ElqLfLl3fRC8/Bm
	 XsIkHhd3Uns4AeJjn4jhUhZv2vIq+odI15cylcYzsTgOLpACy5nKaXVDEHyFrbfD2S5bB
	 +bJ2ffnR06ny5roLbe4AfYmIPJ7JEMR1eI0kXSptIscnNoAZ1TSboIMs4HNH15PuTcPEH
	 nc5WI/78Bb1ITUCbZlgLvS67LegxyD4PcStlviA8IFe2OeERWQOLvC9wH77vjpxlkwjPV
	 Ols26QrZwLcqnLUDpeE8iqSHfEO3cdzCGMRLlAK465yXx4yXxFrCuUupRWJh3jNGACw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="DNI/c0Gl";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAAA606A327
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 13:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADAAA606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DNI/c0Gl
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1fa22006cso3016665e9.1
        for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792504433; x=1793109233; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F4S/z3wLn6j43Kaqn3bJJAq9gOmklL0Dy1KFsPWVhCQ=;
        b=DNI/c0Glu19KVbXdrcsZDBVHr/o1y1q7ftTjBHkscyJsr4xq1wT6ttvP4qz0Boqcha
         ZH/mF1PJxNuvG1Y8GnpqjBvq1dSum/g6n+7gciaY1PYXG21EONxrGtcj7dMUTnv1dWgE
         QLEmfb3MeaSfVRnUt1O2RwqyAmC/UI5+caKFEHj9PKiKjQ7J/M4meo/dZ9/QQ+MBD71l
         4lXkr0O6shR14m3dDEjqtcsNfsJ6qY984Q8/6fKZ2boar+feHOdFlaSECZrsOCd1E+JS
         Ly9307HnZCJ27m+OIHMt1NKv8IlYYdPvGKEUgsCWpFYLjQcyxQsKBdFf84lQRSvaLF+L
         1Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792504433; x=1793109233;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F4S/z3wLn6j43Kaqn3bJJAq9gOmklL0Dy1KFsPWVhCQ=;
        b=UpsKbpP3U31YVueCzSxrywAhuE0WtsvhD9xfPMwgdN3iOGXBfAOzeASkPiKRuF8go0
         oBqwi+F52ixcGQewpd0Bam/kugZmy5u7nOg32tuXPf0JJL/kvQBVo+ugQNt3AS273j63
         g1lM0jhm+6GgYEyHjyjNHnqVjrRVGx9AcPwC2/5Q+mv3bFQ5amZzXRK10VQ2VLnGjBBy
         p+QiDAQEDIpFxpb5YT+ExbLvlWTVoZTIe6Hc3otFZ/YiDhc5b976S0a0D6NQsqWJLH3k
         Kk2nL/5YMgnLV8uHkRKXMTV+k8SlO4pZLgznAsVmIneb9AmOrjb2BvqwbGlMECR1ejL0
         LTFg==
X-Forwarded-Encrypted: i=1; AKwUvBz1/vE/jinxiUV3BV9enaT/vYAPFFXUpcE6oI0OVPL+9nKZPpXWtVMqqulCmCIrbrVZyIGCetWVbho=@vger.kernel.org
X-Gm-Message-State: AFq9FYIXFKs3Qd4Sex71VULLXGpVcTfFpl4BrL6elNawI9xwftw3aYHN
	IuJvZM3WqQSUKirPyyFvi6Rqb8vhmYgSNeq5PyfvspzUIEUQdB0JNsY+
X-Gm-Gg: AYBFou25g0n2vLJVFtZFZ+oC7LQzwAzB2RCyOa8yKk/BfFfd4w6WXgZdZBsSmWI5P3N
	SQiFm2eFM49ftUP+i9rsIOSAYYfRdNgRYvIuwm1DRrHSB/IwUpeRMH5RSX6agaFi6UUmB/qgdzL
	FkPngzNU9XxWQXyaiuQ1knYYv5zk95xgh+YK32U125i+ok5I9gZ4pAAP51fbp7/vhBGhIl5cEv3
	XPmEqGzT5MCcMvUSkhjdK6iiNpZYbmg+fGHyVJIlTYdF6O8onEOEsRrTQ23/HXRBJ4dOTHkEppv
	UByE2LHCtSYiausXt5Wcr3x6zG3OgEhH1uevDMJ3FNUve0ECcjS/R5/2C7hF23bgzZU3iGAAoiS
	GmUW9swR/h2csosCiSX7tkhxXmbaZTqC8R2aOoHMufvBmUbn6XYcmO6oWEGYkCuTX1wUA/Js6DK
	2x5X1AR0QQpjj68y37fCsd6VvVZRH1JT9GABWq9NKH5abn+zcfGL7Q9m+AYFn0wR7hvlJfvMlY6
	dXw3A==
X-Received: by 2002:a05:600c:4e0d:b0:4a1:e7ce:107b with SMTP id 5b1f17b1804b1-4a1e7ce1570mr128096285e9.2.1792504432871;
        Tue, 20 Oct 2026 06:53:52 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cb6d82sm68132705e9.5.2026.10.20.06.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:53:52 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:53:48 +0300
From: Dan Carpenter <error27@gmail.com>
To: s.grosjean@peak-system.fr
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan =?iso-8859-1?Q?G=FCnther?= <stefangun@pm.me>,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 00/10] can: peak_usb: fixes, cleanup and input
 validation hardening
Message-ID: <atdybEUQ9EUdZ9A4@stanley.mountain>
References: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020-canfd_check_channel_idx-v5-0-a62b35b867f0@peak-system.fr>

Could you please slow down.  Only resend once per day.  Otherwise it's
a bit like involuntary pair programming for people who are on the list.

regards,
dan carpenter

