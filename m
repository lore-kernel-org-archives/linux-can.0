Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780232;
	b=122yY2FQN/vlSApx/5gJ0U3NcjG0oJg0qF3yeS/YVyHXxM4pgZ2mYVLsniYsF4GGVvDz
	 3+T6ftFO19YhCfuL41R009CE7oJnf73rtjyxg2tFRnZFWfDR6j+8bZtE99LQrG5NirctQ
	 YSWdiWSxVgrtFb9D3Ze2vd60qcvGnp7gWOgmCFIA7tCwMfnvaDQdV3yvNX7FIJFiQzEQn
	 LErJIZxhvlRWqsBe6NRKuYuQkAwOr6h0Wm79xzQT/AapoW15245b5Gwkoa6ME+tlUfm/E
	 jyiibznDxcB3djzPYvuJO1Th0xAJtXYqddiXb3jV7QzTW2FQUcP0Sh8eHJNLsGI0OVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780232;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=UZMIWNCxN4GlBbs8wN2qI5V5nC29/m7Tp3OI5kEPtl0=;
	b=b3v8ySSzEbutf4iv81qWqR3nUEJCq9a0qFNOYR2kMG/8DUPAQzx/bX3fd2tyUNPb72UA
	 Y9PaQhUSbkMwh/Fga768Sf/K8qr2hiYIsaWbAiFWwn7bprr/I2CqJseUiUbly0j3c+Bnt
	 GlFvxwZjRkvGzyDSd2gqksjtEmKoUHyVaUBigDQTfbx/Q6BCajs1Sql/G81xaoep4dhhw
	 g2cWzCN3qRGtTMIdL0Tqg1gyWLzFOofL96rXcezUX1RF1xm4tZDsHtSdFShgcTJrEyRwj
	 acqZmatRNyziqCmhdGkFRWALRXCfyEYj24+wid7qJBV0ZDED2KGzArs0U99Me/3AqPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=H+ibEUTD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3663D606A31E
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 11:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3663D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=H+ibEUTD
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.4.pengutronix.de [10.9.0.3])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 57DD0202933;
	Fri, 27 Nov 2026 12:50:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795780229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UZMIWNCxN4GlBbs8wN2qI5V5nC29/m7Tp3OI5kEPtl0=;
	b=H+ibEUTDF6kIJyBjGz8+fNDH8ZjKKP+aK/2Sjxb65uIa+JN8ejRGaa7n2NAhlWb49XIcoE
	4Kp9B4PP89dlSzr3x4szOvO/ZP5n72p/cm/cYVMpVzpMyM8m0aPG5yM0gXXJTfr0dQ8/D2
	4EHvipclIWBZFDkxUVJqiKJieToZ+ZprrXBokGUnBc0PO1wcctJXMWfK9djyOnH29jdaQI
	n9wzSGsZmekOwS3y7AQfCsF8/cl0MX76icInw+nmQTjD5uXLBlB1mWY6xCvpNt1h156O/7
	wFngh5gspn0qTcBGaebvoqtOpNP9f5piGqz4vZHB3MvDTitdCAYGi6kNbXWtnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795780229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UZMIWNCxN4GlBbs8wN2qI5V5nC29/m7Tp3OI5kEPtl0=;
	b=cPfc78UVBgRSRMGiC+lVctAV5acAmuFMUHBmxgR0GnLyuQeAHaq7Fnw7+Y03rN73KOAwTM
	h5hrQjJA8uQGmBRrzPx7gaWFvXEFywwmE8NP/BYZfIs1ewfgm8vB4vtT7Y1iqP7g0RD3dy
	DYEuqTOiYxRDMPYZnF3RAZDYnivURSkWt0d5cN/Yfdv9Pv9/VhIH2hBNpWtSC+U+cYB93D
	9SQLPkbW6jAGpk5Kv6Ogv9hWT8hx0W77HPVJBMiIo25350h+CkXgFuWBR3VRh8y5yrN4Yw
	du7EPxp3uJKL740s0mZZNqj3a9Xh20Y6kDOvlZ1UHJHkMn8bA2k41vXlMMl9dA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795780229; a=rsa-sha256;
	cv=none;
	b=G5zexwc8FOngnxFqoB0caMLxsoJP0YTCxfMtsQRup/g2vucYswRx0+zaUOBll4WrtbhEkt
	HEFnY3BRT7tlcDLUDmLxHzr6aIeJnCevqlraug3RCbVTeKJAggXNUvYw5HkpV36vD6CmMu
	VJa91M9Q7DHYsCfke92eOtQVJCTlTD/JJje3b0SJtOSZvQnUxz0oaM6m/gPrB/VVX33wVB
	B9PN0n+D8USl5gPknyva7NRIRwMEJrXMTKOzro7/RJ/vcfhOCZZvJ1nrDSjq4MeKFGkWxW
	uCVpZKEhJupxcatsV2njjC5VxpjnXFDBnokkFe9Q4B++5cWxgaLKfIT1kXuUWA==
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id 400241BF7BF; Fri, 27 Nov 2026 12:50:29 +0100 (CET)
Date: Fri, 27 Nov 2026 12:50:29 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next 03/22] can: enable memcg accounting for user
 triggered allocations
Message-ID: <awluhW_a2C7mJa2b@pengutronix.de>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
 <20261126-getsockopt-memcg-isotp-v1-3-681ef8d8c2c9@hartkopp.net>
 <d65925ac-364d-4fa6-adce-dfa4027ef509@hartkopp.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d65925ac-364d-4fa6-adce-dfa4027ef509@hartkopp.net>

Hi Oliver,

On Fri, Nov 27, 2026 at 11:08:17AM +0100, Oliver Hartkopp wrote:
> Would it make sense to split this patch into a J1939 and a non-J1939
> part and to post the J1939 memcg accounting when all J1939 fixes have
> hit the mainline tree?

Thank you for thinking about it. As far as I can see, there is no need
to split it. The J1939 part only touches the j1939_priv allocation and
the SO_J1939_FILTER copy, and the pending J1939 fixes I know of do not
touch these lines. If a conflict shows up later, it should be easy to
resolve.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Regards,
Oleksij
