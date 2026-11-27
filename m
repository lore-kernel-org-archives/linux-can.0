Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795772462;
	b=ZpXORjYtmkEGB3vwiPCsD0oJniBhl+KbYHfURdE38/9BXZ2vPAEZG300Oz+19bKs8d4h
	 DrRDMny4+gWJPFGAU2zsFjxELrptHdyQqz/hSVGpJdgxyLStLo5B9cup7edAIuG0uBp6V
	 legi2t4ttL6H1Corjz6GQ6B6GNV1+46Leoyknrwf11LzKcd5x+PKbud2jpeGHALbb1WaP
	 6BbeRHGKlYJrcqSjukXElItsOPy+okTI18aEUCXkG9XVhk4R+qC/Bx7ALtjyp58jDyy88
	 DnWXywC0htfbUMFPEdDpLCBKpudUcaMhuu749rJpB5mff2mt1+WPailaDEYm45fGGJA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772462;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Xvf4CgLd6viibhHWdU7ODPQpwHb56dT6FS7Upu3DSNg=;
	b=jrIGTEXX7ZjhUdfg1WYmccppEmTa88Y+lbcOw1rSs3qbD7SxBPbdwLfZUopOccOK3Wdo
	 4ueKJw1rx9pGSTl0VoezfvDFcvDCbe8WWNLjz+pc6HYBHVUIjlWWm5BliVU+e3OM0KrSH
	 3ocBWrXLJjL1TkhzVJZvnN77BO7xXq/SKyKgsxbmSyI3y2VQ+RJbjfrOWjNY6q9N/3xd9
	 V3TZ2jj/pRLtUrsUtdO8z9fFZrftQ0lp0L15pHYok4xu77ps7pK129iIRHXs30oS+2Cuf
	 Huj4OblWhGqv/OoTQ7vJ3fx52lwTTxDHOPJilZa0G1tlJvq5Nvl0dvsH+14n430fVmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MkQC17ku;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1D6606A31E
	for <linux-can@vger.kernel.org>; Fri, 27 Nov 2026 09:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB1D6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=MkQC17ku
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.4.pengutronix.de [10.9.0.3])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1B9AD202492;
	Fri, 27 Nov 2026 10:40:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795772453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xvf4CgLd6viibhHWdU7ODPQpwHb56dT6FS7Upu3DSNg=;
	b=MkQC17kuMhWAxqTJFTSNMED5lpo0NqKxtew4tGE2kj9tAaXc6ApJ8qedWWTxMp72o+TDi5
	gh4ZxPTHoMVBlXNlSUUMvQ2vzxcA+eyr0Dl2nOscOm/He9wrA6ES/ekmHURpwqVioh5g5o
	z0F3q3/lxWL6Vkd0BBar4GodQFVM2gLLcbGJKUqA1A2+CXiPA9YV1zEVSZSMea3fHyRFpq
	h4eSPM7ikq86+03kBUiUETBKFtyn5h6VE5jJ91XZ6w40xwttl00JEhyUTCPSi2oytPCybC
	WPw6VUjTW50/hJhK3OKcnJFw09WaqIHQ22tfn6qMscN/lum6N5jBlgpaGCf92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795772453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xvf4CgLd6viibhHWdU7ODPQpwHb56dT6FS7Upu3DSNg=;
	b=FaIh9I+Z/g0zp0U0EmGA/jGNLqqS5Fy6oPAwsJOgcSZGf6Q3L/f2cIbua9jPikI907BfgR
	IdW88/4Hu7/ID4P27cXqlnGL14INCrgCtyoQfLLOVw0RctO8+iCTrpZlIBTztwyjLUc3aj
	2Vb+va0jlQ/bwOMem2vgz+CItaW+Y6P2q24yeB97r940PHuBcw+Qx3HRfWvtamkkqrKH3D
	L4OZMiIpiQSSq22T5S8NItcP4khOW8BMaoS+vTbXZ7SS70Ly72mSaxF0aUcyNAQWSaGbWd
	xVQ+IajA4Cu1YANhpjnhYDMZWhp8MU92wDGVITpLXfNveG4ZaHDDJtsyOZ9EGg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795772453; a=rsa-sha256;
	cv=none;
	b=Hp+Xr3vlalHd6qK6cjLyrhTVqR8IFEdb2cRpTyDamNeVE/xqUIz05AQ6GPODAFG5MJpt9s
	Sec9JtxGoRqxYncuOMHQl5rnf1F6l4T7PUTeHBMLZ+1qf8l8qzaxJlP669Y97c4u3K+qMT
	lQrnYD5+dYilel021k1s1gpJdP63mHcx/NnE/CphWfpRUJtB7q4/eC9z0q664ncBM6mrba
	VsCLSq2es/3WkQwWeSX9AI21umWimRNPQ7K5hLSylByU/8zNsTtgJ3eDPkflpzdBvb5ioU
	JmSP6xSeG6C0NoEXZaNfRz2JpFTd7VzDjsWliIu9hie+bAagXsF9prxjS3oCTg==
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id F2C131BF4DE; Fri, 27 Nov 2026 10:40:52 +0100 (CET)
Date: Fri, 27 Nov 2026 10:40:52 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH RESEND v4] can: j1939: cancel all pending ECUs on device
 stop
Message-ID: <awlQJD0GXoDQQ65m@pengutronix.de>
References: <20261126082257.491041-1-dmantipov@yandex.ru>
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
In-Reply-To: <20261126082257.491041-1-dmantipov@yandex.ru>

Hi Dmitry,

thank you, and sorry for the long silence.

On Thu, Nov 26, 2026 at 11:22:57AM +0300, Dmitry Antipov wrote:
> +             if (hrtimer_try_to_cancel(&ecu->ac_timer) != -1)
> +                     j1939_ecu_put(ecu);

Unless I am missing something, hrtimer_try_to_cancel() returns 0 for an
inactive timer, so this drops a reference the timer does not hold.

> +     j1939_ecu_cancel_all(priv);
>       kref_put_mutex(&priv->rx_kref, __j1939_rx_release,
>       &j1939_netdev_lock);

As far as I can see, j1939_netdev_stop() runs for every closed bound
socket, not only the last one. So this would also cancel address claims
of other sockets and remote ECUs. And an address claim received after
the cancel can still arm a new timer.

If I read the code right, the leak is the reference that
j1939_ecu_map_locked() takes when the timer fires after
j1939_ecu_unmap_all(). Tetsuo's v15 2/3 stops exactly this, without
cancelling anything:

https://lore.kernel.org/all/f778db47-a217-448e-9dbd-f1860afab00b@I-love.SAKURA.ne.jp/

So I would not take this patch. Could you please test the whole v15
series with your syzbot reproducer and reply there, ideally with a
Tested-by? If v15 does not fix your leak, or I overlooked something,
please let me know.

Regards,
Oleksij
