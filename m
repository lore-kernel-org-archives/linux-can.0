Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792655872;
	b=Abg/2LQEYgyEbQjuEAbDP0nzj/H9AYIY8VnVWkWaxyEG+cXf8u3HdAlAUFbGKAxX8xRd
	 9Jq8A+u3RnADMZ9nOyUp6HqoYCGF/xae4XMfqsJOLm7OggkFVN8fihJ84DD3RABdUXgYM
	 KKx6/mhdPrSU/8wmibJQ3l/zjiJylUt05rXvVdaABSeU81cvhmss5FgUyNs9LiZXA75Hh
	 1uXFs+s72Yf4F26cTdE6uTrE0CNPQOgr2ZXx2/qqDu1KTsi0kQXYTXTVEMyrOiVnJDV+/
	 HnAaIl38oNySXajcKYPm6sEvBGVComniYtk80hg8BiIQxAv4ZwKG+sMB5sD4uwqE1Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792655872;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=YChuMtaO7XsylPSj8MWrQC6Cei2lU/019AA7OWlvrYM=;
	b=HfXMpJSkohw6cLBnCFDNq7VxaxIxhuzaXunW05N4BRuAwXR1nC9drxGDbjfMETa+EbDP
	 J+MkeN8aL64WwJNHZ/+d0pGK4ST4owVEpbfiZemZVe7zvez8Uh1miDrMgYxKI7JD9Ucdh
	 92IIElJPC2oeBxDNme11aBVLj1T1oDjxq61OpNjE9E9AR+iRl9QXhHramaL8VU38pZs5d
	 fIvjLcLMYvEp2ZabWHVqxtfPJzPJk3RASTgtSsKpDvCxxSdWlV1oJ8bHeXgjNHjZ6REYD
	 81mg8R4EARcvpLLMrBiohYdGsFzlxHKGo36pCzxR005UFTmDVzzgctiVPgdsPPT/L1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="kQjm/HLh";
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04708606A320;
	Thu, 22 Oct 2026 07:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04708606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kQjm/HLh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Content-Type:
	MIME-Version; bh=YChuMtaO7XsylPSj8MWrQC6Cei2lU/019AA7OWlvrYM=;
	b=kQjm/HLhY75YwqUxabceDyErDfCUMXz8TreC5LaNZgikH+Ib24O1PUYyTYVsn/
	CDo64/xIcSbzjI1DghRfUR8sqgZC0r544Y2rRn8zmEhV2CSohsgmKcSKZJ5I0nPz
	wLr7SnqM5Lj8rx9soFZSSWHpdRuuTHI+Wv50rNPHFwb5s=
From: Quchaosheng <quchaosheng000406@163.com>
To: Kaixuan Li <kaixuanli0131@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] can: isotp: check the frame type, not just the length
Date: Thu, 22 Oct 2026 15:57:37 +0800
Message-Id: <179265585720.316860.4020901999690965834@163.com>
In-Reply-To: <20260920035626.2581040-1-kaixuanli0131@gmail.com>
References: <20260920035626.2581040-1-kaixuanli0131@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:QCgvCgD3a5fxwdlqbTtvBQ--.42500S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryxGrWxAFyDGry5Jr17Awb_yoW8GryUpa
	y0qF1DZrWDGF9xuw12gw4Fv3ySyw1DJFyjyFsrG3WUZasrWr1DKrZa9w10ganxKrs8AF13
	WFW5WFnrCr4DGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2iiDUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BK9M2rZwfJOBAAA3y

Re-checked this against a 7.3-rc7 tree before it went in; recording what was
measured.

The field offsets in the message are right:

  sizeof(struct can_frame)    16    CAN_MTU
  sizeof(struct canfd_frame)  72    CANFD_MTU
  canxl_frame: data at 12, len at 6, flags at 4

canxl->len == 4 makes a 16-byte skb, which is CAN_MTU and passes
"skb->len != so->ll.mtu" on a Classic channel.  Cast to struct canfd_frame,
the byte at offset 4 is canxl->flags, and CANXL_XLF is 0x80 and mandatory,
so cf->len is 0xff in the run below.  The flow-control path uses that length
without bounding it, which is what check_pad() walks to 255 over.

Measured on v7.3-rc7 under QEMU/KVM on vcan with mtu 2060, two kernels from
one tree differing only in this hunk:

  A  a CAN XL frame with len 4 injected into a Classic socket with
     RX_PADDING | CHK_PAD_LEN | CHK_PAD_DATA:
       without the patch  recv() -> EBADMSG
       with the patch     no EBADMSG
  B  legitimate traffic and the padding check:
       CC ok-unpadded / ok-padded / wrong-padding    intact, intact, EBADMSG
       FD ok-unpadded / ok-padded / wrong-padding    intact, intact, EBADMSG
     identical on both kernels.

B matters because the guard sits in front of the code that reports bad
padding.  The wrong-padding cases still report EBADMSG on the patched
kernel, and the CAN FD channel is unaffected.

Reviewed-by: Quchaosheng <quchaosheng000406@163.com>

