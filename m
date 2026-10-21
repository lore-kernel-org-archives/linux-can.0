Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792571167;
	b=z59JbCg4bvhItFo4xTtLRQNwe4sJHNFkFYQwXsTZLpDnyVNTtipe7m/74QyxqWJhmyo6
	 DH3O2N9Q0pp+jBifr1GY0kYYlBwRGVsLsJAhDMtIwdZa5l/KDM2PFZQTY+GPU/nV28AtV
	 A665FAr2InLaWBrCaCQaALaJysWxSKVp9TMTLeGxy7kKJ/4y8UX0oMsv/wSRoEOJu2npW
	 RZ47K1AeZVSxVYuo5zAw/KuKxZ+Yi+kxATLsCo592GphAsRzKiEhxyBw4dwpFA7iMCqE+
	 q3HaP94GCsk5EXRWsGqW7Xt+22IIhqZtluoKzO6mlDlUAEDhxA4xHUCEKqpJJ1cRtdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792571167;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fIZs8nGdZXNty0t58NAfFIss/aXd2UkNafg7OSbEIpI=;
	b=215TB0fRXYbZeUWHpxI86cL9wfsS3p0xVPv97CreG9eEgaHrMpZ6Pv4drH+tDLyNhjyW
	 7KuBEh/VTZJ0IuEhDSkZt8pjfCctERzL7m0hJ8Ih4sxhMZAvF/23nOMqd9YgtFSUHXlXy
	 XPb7jVO/qaYGeWru/Dgi7di10xj8mHsOeXY0qzUECh8bMvTehzERcw8aB2TqDt5lpfGg2
	 kAFzDru/zoeuKtiCNdze84vHwrpcWI3n7M75xwa8FXiV4kxpVkK4WAftsf30CpuDA36Pq
	 tI2D7uhfGzIiG5/8QffTBiB2bWUuK2dFNjASFQYu0D18aisBlP1uNk4vg4gY8CfdvJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YwPq1XdL;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eEw2ybo7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1C606A319
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 08:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12C1C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YwPq1XdL;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=eEw2ybo7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792571165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fIZs8nGdZXNty0t58NAfFIss/aXd2UkNafg7OSbEIpI=;
	b=YwPq1XdL6AFIS0NSuRPd6DOXWe1Zom7lX8sgbtnh75+bB9jkCYdYD4WtrenAFlZMjPEyMI
	z2UKJAgy3bwt9TL4lsjUMRFf9q4cP086iTaqyp02YgxRVFYmdt1i01lijivyPHyocUQpo4
	aSW/fP2Ojtmpo7gv67DzxG073fnqvbI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-qJf9tgKbMw25TeT8FPOnCg-1; Wed, 21 Oct 2026 04:26:04 -0400
X-MC-Unique: qJf9tgKbMw25TeT8FPOnCg-1
X-Mimecast-MFC-AGG-ID: qJf9tgKbMw25TeT8FPOnCg_1792571163
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so4220395e9.3
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 01:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792571163; x=1793175963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fIZs8nGdZXNty0t58NAfFIss/aXd2UkNafg7OSbEIpI=;
        b=eEw2ybo7N0R3izXXWLmhLfcu6J3AXPrOrdQVTievsd4remumpVKGDCfsIIz2hBNrwX
         9medW9wuER2ZWhtTQvkwvKfdWShBxBBrODNuOp36Axmr8wg7tBvcBYPV/3i10ouy/5WL
         h+fRajCJRT/3sClyAlSM2PXnvaHhJVYWtYvj/pOaWdxgFIPCjTPHJt1y/AqVEIRBK680
         mq/yRN/6oZLLeC8H9Z4bbZjZH2tJwHXrCofn72WYZNgcJ3omNl9kSmpHcYAs6c6I1nXa
         YJB1d4x7IpiXydIeG0fh+PpmnkWRwM2X5kKVfnyqQGbpb3bMXr50JULX8COz9ovy9iUu
         ufcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792571163; x=1793175963;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fIZs8nGdZXNty0t58NAfFIss/aXd2UkNafg7OSbEIpI=;
        b=KGPSsnbCo9U5URiP+DDO9o8tCZp43wGqjBV2TY/aihMj42IXUVQaphGy7Ev29hpAVf
         bAn70aNqzRug2ucfgmZSvAaRLg3I2TLssYoqmmYMeyA2hn+CYd0WWJF3cU0ovZn7226W
         H02UmY8P+8MP4NM2yNulTi/JoV6/SqupZ3HR341k9BC5dAms7Zwfzgyrnqides4qC2jR
         n/sDEpFfc3lgYt64tjcb82+geyByxesfOxoqngTyG4UHieuGinzgsX45hwKsnBGX1D1E
         yQ/xgKunJqwR2oqWW6dXxqy7mEjLUGkgGAl75nG0xg4XCMrEeD24q4PgX/1sEOh5aA+Y
         lYgQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVC8V/+kTZdST57PhMuGtW8Ab8nWERi4q9YmHNyAfWhgzIt0+Q4mcWyo1e0ihoQWxLSj2HeIgslrc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPySUSCJztbf3nVWU/nfTRQVwkOOCwc+9I7VrdozmbHO6/N2ix
	gBNqqxTkp1heqe/11ShmnnWFsS+jM560Qf4mWPlqaB7oYmiyBim07YQvftn0vtNI1PHienwICaM
	F6RFLvgzRRYCtSBAIv/CFQu3NW3i7bnoIjkPOG9SefAEfoyOddbhz1vMWfxheIQ==
X-Gm-Gg: AYBFou14GhE7oxrLUH8zpIImdz3PdTwzL+CFv/4LVt1YMza0nh3f5OplwNLsksLsZNz
	Eh7T2hhUenkvCZ6mUq4BN1e+byuj4ydVQ513gS8STAR+QYT3YWA9fNcdQAlSqzDbxf7fyKmNiNC
	vp+gi58exjKq8UStDMG28pL5gbOylyHEc+kBA9GdmBzLC0S9psEWxP/iIjT+sDNBSK67GSTYVgf
	Cqfxw81DZ4/SXmkeTZALYuyhpaVOIDIodQRZFCGfibwrtD3hQxapU2mNzq9MSrnDxH3Iv4RlQHF
	WCo1qSjl9fgnSNjhSP36S04Tv82IdIxrwMStWUpfBu0ZwfE5bAzN/2GlN5zFnYmR1JMd9KL1Lbo
	jl/fTLQ==
X-Received: by 2002:a05:600c:c094:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4a1fdd26e79mr20791445e9.27.1792571163103;
        Wed, 21 Oct 2026 01:26:03 -0700 (PDT)
X-Received: by 2002:a05:600c:c094:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4a1fdd26e79mr20790995e9.27.1792571162696;
        Wed, 21 Oct 2026 01:26:02 -0700 (PDT)
Received: from storniolo-redhat ([130.25.253.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fe5239e9sm25898645e9.0.2026.10.21.01.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:26:02 -0700 (PDT)
Date: Wed, 21 Oct 2026 10:26:00 +0200
From: Filippo Storniolo <fstornio@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Urs Thuermann <urs.thuermann@volkswagen.de>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-can@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH can-next v3 0/3] Introduce diag support for CAN
Message-ID: <atfFeR_OEaWrcQSS@storniolo-redhat>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20261020-funky-buffalo-of-progress-fa4bf9-mkl@pengutronix.de>
 <d23196e0-6307-458b-ba31-15f54ef46b73@hartkopp.net>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d23196e0-6307-458b-ba31-15f54ef46b73@hartkopp.net>

On Tue, Oct 20, 2026 at 06:20:22PM +0200, Oliver Hartkopp wrote:
>
>
>On 20.10.26 17:50, Marc Kleine-Budde wrote:
>>On 04.09.2026 16:12:54, Filippo Storniolo wrote:
>>>An example of the output given by ss -cpe:
>>>
>>>Netid                     Recv-Q                 Send-Q                                 Local Address:Port                                   Peer Address:Port                 Process
>>>CAN_ISOTP                 0                      0                                              vcan1:1110                                          vcan1:291                   uid:1001 ino:50324 sk:0 users:(("can2",pid=9210,fd=4))
>>>CAN_ISOTP                 0                      0                                              vcan1:291                                           vcan1:1110                  uid:1001 ino:50323 sk:0 users:(("can2",pid=9210,fd=3))
>

Hi Oliver

>The fact that the inode number of the socket is visible fits great to 
>the upcoming CAN procfs output:
>
>https://lore.kernel.org/linux-can/20261018164417.1540449-8-mkl@pengutronix.de/
>
>But I'm not sure about "Local Address:Port" being "vcan1:1110".
>

You are right and probably the example in the cover letter does not
fit the best use for the netlink message.

This is just how ss show numbers. I used this tool as proof of
concept during development and I didn't put too much effort on it.

>A CAN-ID together with a CAN interface is a unique "content address" 
>to identify the content which is in the CAN frames data.
>
>I assume "1110" to be the decimal representation of an 11 bit SFF CAN 
>ID 0x456, right?

Yes, it comes from 0x456. During development, I was using some C
program to just create CAN sockets. The socket configuration for the
shown example was the following:

`
addr_send.can_family = addr_recv.can_family = AF_CAN;
addr_send.can_ifindex = addr_recv.can_ifindex = if_nametoindex("vcan1");
addr_send.can_addr.tp.tx_id = addr_recv.can_addr.tp.rx_id = 0x123;
addr_send.can_addr.tp.rx_id = addr_recv.can_addr.tp.tx_id = 0x456;
`

>
>Having a CAN ID in decimal representation is generally unusual - 
>especially in Linux. Additionally you can have 29 bit EFF CAN IDs 
>which does not fit into a 16 bit port value.
>
>And 29 bit IDs have to be marked as you can have the value 0x456 in 11 
>bit and 29 bit CAN IDs. We usually do this with 456 and 00000456 to 
>indicate 11/29 bit IDs.
>
>So the "Local Address:Port" output does not really fit to CAN here ...
>

I can update the ss example in the cover letter with something
that better fits a real case scenario if you want. 

>Best regards,
>Oliver

Best regards,
Filippo
>
>

