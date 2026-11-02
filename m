Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616845;
	b=uVCkQSAAPFxIZDL+o4XV/ZuA7qtvUuXWnLkujFFKX5ypm/5wIOAKfBtDAc8CvVumx8LP
	 9Y4CC8BDOswNpVlu14UHBjcR4CMGM0g0+Ox0BgKTDSuXcDONewN6UN7CYpGPswQR4PiBz
	 l0JXpREkqc9svsisQ+GoC+El320jXhokcB/gGK7x+qY6BoZRrUEFaVxwTlDmIApO1FnGT
	 T737jMhK4/Yi9ZugnG/s/X6OwkWNfa1z+uRkIewJhcS/pbn59pBmWVchVWwLTgN6whyh0
	 7t+7puJmFtQcSCYPbdknZL8lORMexa5PmFwWUsjLGVzZCwxtN4MPgbF1PsFQRweDDqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616845;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uOLHsJglQ1X5vFwv64Slcrga0/zNzpNVq72U0WQvNTo=;
	b=kHDMgUlNjsz6CnftIa/J/UXIXIzRVZj5NeRs8vlGLHWunX2U0U4Je1EcVtZ1U6ZMRsKw
	 kRs5y+KEvA5aqcyeHXhRcK3SpgydFo8e8NdXeyaMQcToV4fD3FlFH+XCqIAnzYMtdo5CI
	 9hM86UiUzC4roXK4MbVsnY7MNF050kdBt5efZwHdiSinO7g8MpIT1pj/VIywfQoxPiOfG
	 nJoXWPpIEun+SpgIVwGMcimSESreLOaD+jCbDnP5Pt0D+a8aSD9F2Ch+8Ny4dcvZeP3ZV
	 wNrwr957IR24uEJ/xHQ5xKodlYt4Ui4xxZsiBqK42ynjIF/BmsYlKWqGYiNprUFKozw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=fHinOaCa;
	arc=none smtp.remote-ip=212.27.42.6
Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510AF606A326;
	Mon,  2 Nov 2026 10:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 510AF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=fHinOaCa
Received: from stf-laptop (unknown [82.96.140.143])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id CC88C780505;
	Mon,  2 Nov 2026 11:53:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1793616836;
	bh=lI4x+3EaQKGyIFjkt2vzYdtHffN0Dw04WYcQp1csVDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fHinOaCaKzp+CtizWKb8FeZbY6TcMaLq7D8gzL2SSmHIXatxdXzWnL2X1v5cs7IMB
	 McVqlRpu3JPPXu0EJnof5gLK2SpYU05Eh9JEVuYjZJTD4b3sy4N8tsfpcAE+j8M/HK
	 oxebg0aG9q9VoU58cpoGwQIvE0GrgmZVrTI5qi7858MQbbXmUCPyuVP0stNsWB3oat
	 F/Do8WOZ4shbRVfoWibdx4liys/upw2P5cL15OLyYkCmU2Ycjbru2FMIY7xeDVs/2Q
	 p1JEO+PThWuoRmlUBaw3hhsw10Guh5qsj7iKBVkI3YTlypt7cNQAupLZdWLheunVYV
	 rKawvdvM707Jg==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	wg@grandegger.com,
	error27@gmail.com,
	lukas.magel@posteo.net,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tristmd@gmail.com,
	kuba@kernel.org
Subject: Re: [PATCH v7 06/13] can: peak_usb: harden channel handling in PCAN-USB FD
Date: Mon,  2 Nov 2026 11:53:32 +0100
Message-ID: <20261102105337.29362-1-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179349932777.3127.4920937034375531815@kernel.org>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr> <20261030-canfd_check_channel_idx-v7-6-fc4a3faf3acf@peak-system.fr> <179349932777.3127.4920937034375531815@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 01/11/2026 03:15, netdev-bot+sashiko@kernel.org wrote:
[...]
>>  adap_dev_free:
>> +	/* the whole interface is released when probing a channel fails:
>> +	 * stop RX on this channel, which may already be open, and on the
>> +	 * channels already created, since their RX URBs may carry records
>> +	 * for this one.
>> +	 */
>> +	peak_usb_stop_rx(dev);
>
> [Severity: Medium]
> Does clearing CONNECTED here suppress the shutdown commands that ndo_stop
> sends for a channel that is already open?
[...]
> Could
> a probe failure now leave the controller bus-on, with calibration records
> still streaming, while the device stays attached?

At this commit, the only way to reach adap_dev_free is a failure of
dev_set_bus(dev, 0) just above: sending bus off to this channel has
just failed, so ndo_stop() would most likely fail to send it, and to
turn off the calibration messages, as well. Moreover, the channel can
only be open here if userspace opened it between register_candev()
and dev_init(), where opening it already dereferences a NULL usb_if
(the pre-existing issue you report below).

As you note, patch 9 removes this call, and no netdev is registered on
this path anymore. So I'll keep it as is for these three commits. v8
will mention it in its changelog.

[...]
> [Severity: High]
> This is a pre-existing issue, but does this CONNECTED test close the
> window where the netdev is visible before its private data is set up?
[...]
> [Severity: High]
> This isn't a bug introduced by this patch, but is it safe to call
> dev_free() before unregister_candev() on this error path?

Both are pre-existing, and fixed by patch 9, as you note.

[...]
> [Severity: High]
> This is a pre-existing issue, but can an asynchronous restart URB outlive
> the peak_usb_device it points to on the probe error path?
[...]
> No patch in the series tracks
> or kills restart URBs.

Right. The restart URB isn't anchored, so peak_usb_unlink_all_urbs()
doesn't kill it, and its completion may run after free_candev(). This
isn't specific to the probe error path: on unbind, the endpoints are
only disabled after ->disconnect() returns. The window is narrow (a
short bulk OUT transfer right after a restart), but real.

This series doesn't touch this code, so I'll fix it in the separate
series announced in v6, by anchoring the restart URB so that it is
killed with the other ones.

Thanks!

Stéphane
