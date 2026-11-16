Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794848240;
	b=4wJeadasReCmfyYNuVHmSeh02EpsZNmisFdCD3TIjknUTjlgQllnwN48NPLhvrtKRMQy
	 R2Rdu0AHVM9Y5vpgBiOO2AkLzv2veyH1cB7P+XOcMoeu2+LElLOzCy/QQoHEZUHAce8uX
	 h9lXt8PnHM9v7Z3OwJl9JeYcHvG0elBo9CTVVMv3xNVtQ8TvqYSfWIvKEH15oIsTvdKdS
	 Jg2LhurEEYQEdJioA8f57MkPO6KBQD/h7meKMFHQ4e2uuJQki9bKGxFoXHBhaB54UBMVG
	 ONpITlm0s6jvvGST5rxxG7BijUkUctYmmcPuEdbmMF0aLc6Tn4Eak1AZUA1B3qDlk5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794848240;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=3G9PFoMgFrJiZLyd5rGhgJGT9wBQ+IPLOJUmtbLVECg=;
	b=xWx6husBP9zlgaEe1lNLYHDTNKlCAjLolN8IGq1WMfQRhpioObdl17eSY1sUTfGy+T+W
	 6ysJvCc2CxjjvJK2/AkpS6+kAQQTC3CjnjEONzjfTuxyfGTiDheKlpAU68yvr+F5xwHKc
	 pxC2vvMyXkF4OQd5moMX2zdJ3UbmyaeoaBPj4K0eL3mQ48wR5JR4hKdhW0w151s8Ilf18
	 xPw6/xyDWkh0t5CdtiUtvPrCloiD103U25VfQZC0ceGS9RFRZVi+J3DV4ubJ+6tW7tzOZ
	 PlQEyc0WGLwJaWSEvxpQwmTNRhK0E1U+j/weYwiTa7EAAKm9K/9153DVVIYp0PbtE/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=b5BpkmLu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0E606A336;
	Mon, 16 Nov 2026 16:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F0E606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=b5BpkmLu
Received: from ptx.office.stw.pengutronix.de (ptx.office.stw.4.pengutronix.de [10.9.0.3])
	(Authenticated sender: relay-from-ptx.office.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 62D65201F22;
	Mon, 16 Nov 2026 17:57:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794848233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3G9PFoMgFrJiZLyd5rGhgJGT9wBQ+IPLOJUmtbLVECg=;
	b=b5BpkmLuUrEthbPej0hubZ31fkMXa+NzVpB3EAOlXPjbVZFxGEy6Ays3w47tY1fVyXLpte
	7xPud8AzwE6o3SZM2wc1Us5GG91iEZbnLrFM3L+tI7J3fOSAuEndOTTu5ApBYMvM7m1H8f
	dpPGfVxGudSq2Ten95dUjlcO7nuI+jR1tjluE/85cisR8pNSqpfheQncEx+YXri0jXC8Cy
	LRvE+wee/RClNC0VTPv+1tiiOiFii3C8XB7h9zIenshPa0gAGvDKMbfDDiAewk6dv78ajE
	gD6f/6DLN0xjMl7GL7pZaonf1+c4RzbHUZqxehijb0vGRZc7o+Hh66L0YzR8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794848233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3G9PFoMgFrJiZLyd5rGhgJGT9wBQ+IPLOJUmtbLVECg=;
	b=aYOUz7YnVTbeDAj78HzZxfY6xT2g8bQKXlXhzV32ANx1di3qzSHrR4mbK1kVzutCBpsmsc
	wxbb0pdA83TtTcXxmRwjfTK9Gok99ju2AZMdvmkwiMdDg8gsPJmbLNYd5KRVytHXBum0rg
	/ZpxjSWZ9iYvljdKfFZWorRgup658KRX5amYpKrqWG5VFr1Wih6X1sLckobsSuAbizPc8O
	woG7mLk4uhwZFzgxsgaUlQ4RZATIZWH+5WFlJ731r3+xgKuJs1byh1Wr5G4gLdArtLdVaq
	pc3DrtToVaBd9el6cO8leH0oPVIFcDinLGuIgecvjthtJSqltnStwFCuL4xbag==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794848233; a=rsa-sha256;
	cv=none;
	b=dv2QVczAhUb4cHl4xHxXydSwU34+NSoZno7Drn+vsbnh6ItjTExc1T6EVXvMP3721Xdrga
	DUwf9mvPfUCMbWW/sTtoQggJvUA0qbRp1gYvK9BhEbIJFi5DB7aNDdEvBHJE0zg4jVAjXi
	Ubl1v54noyC7UunQGsROK4zYsW/n/+WiWIERh40PXCwTo1g4eZFgA9/bTJXxeRs+zcMOGD
	qQKFmeYi4sltIZrJcH6AEf/g64kDLOAroz5SyZJ8r9z+EAKTwYn7vdR8vK2pnAX0Wgt5/1
	wqA4saG9cPqh+2CbmrKy2uF5ciaB7/kD24Kt5EyU7RA7APloLVvglQNxYwgyRA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-ptx.office.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
Received: by ptx.office.stw.pengutronix.de (Postfix, from userid 1058)
	id 4FF2B1BFA16; Mon, 16 Nov 2026 17:57:13 +0100 (CET)
Date: Mon, 16 Nov 2026 17:57:13 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: robin@protonic.nl, socketcan@hartkopp.net, mkl@pengutronix.de,
	shuah@kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	fmaurer@redhat.com, mailhol@kernel.org, alexander.hoelzl@gmx.net,
	quchaosheng000406@163.com, penguin-kernel@i-love.sakura.ne.jp,
	kuba@kernel.org
Subject: Re: [PATCH can-next v3 7/9] selftests: can: add J1939 TP/ETP
 multi-frame tests against CAN_RAW
Message-ID: <avs16RSSFsaLvU_5@pengutronix.de>
References: <20261111-j1939-selftests-v3-7-5a80277ab363@pengutronix.de>
 <179454972353.488853.9453703448480835098@kernel.org>
 <avbIRi9NIgi6dcEB@pengutronix.de>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <avbIRi9NIgi6dcEB@pengutronix.de>

On Fri, Nov 13, 2026 at 09:20:22AM +0100, Oleksij Rempel wrote:
> On Fri, Nov 13, 2026 at 06:02:03AM +0000, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> >
> > Critical: 0 · High: 0 · Medium: 1 · Low: 0
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> >
> > - [Medium] The patch adds four TP/ETP tests (tp_rx_from_raw,
> >   tp_tx_to_raw, etp_rx_from_raw, etp_tx_to_raw) that the author says can…
>
> pr-bot: cr

Typo in the tag above. Correct one:

pw-bot: cr
