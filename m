Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792600500;
	b=K09qHv7ayIj2CVZMHmi25PG8psHHvS1gLW2ZzebTVKnhVf/ZE7R636XmQPPa54lZbEGb
	 D8GgIcNVqZiixvjF3Ii/E71DT+4aLL5tgT9qGeW/6ePvyPZIXrJx12b1us2wlAaYKF+Uu
	 LLOa4+MAg6dnQj2F4LQlrCOfs+Q6AQrxHfFz7M63KetYJLebvUS62976s53RpPLHuh8dV
	 JISVSwWdHRsbglEKrUSYMRpMRTJvqMWBwZJ3YktlLdCy51BtAgwaqwNKGU5ShGwehVFHg
	 q4cybXV9V+dHShgsg/0o8NQXZnmi3Yongwqco/qZnikOCKkCWFUfQhJSLKG1We4aPfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600500;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4ECp/hbXKODoBvFc0/qb2x8sXCeuzeA2bzCGlNXK2xA=;
	b=f/kD6Rz5UQpuge+jQuSk5GRZPYGIITPe05ZOobv6GAwNKVYuHw1KfaVlWJwfghqjMl5+
	 7X9OK7mdXKK2sNfNmNp1+NLq7xsajTTrjDOywOXTicAn++Y1uBqGjP8Ah6NjqnQO8AHrX
	 qhjBJHXZlp9/WbucYjGubo1KPvJZpQkeRi2Wj7gK0e4WPOZ61o5CEzEFMAnXj/n9TFCfz
	 QvW2o4QsFJqLKVKgERLY2mUstABgnDEUvp+uPKDIc4kG7tr3eBiMyvMHRzB7rJ91dZftR
	 lO3o1U902+rWMwOClCd6veSdskN99Oo+Ok9mSDXou6SXsCgbYk2bH76AUh5YnBVLGAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="P/vNDn1L";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lcvk7lLx;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E31F606A31D
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 16:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E31F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P/vNDn1L;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=lcvk7lLx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792600499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4ECp/hbXKODoBvFc0/qb2x8sXCeuzeA2bzCGlNXK2xA=;
	b=P/vNDn1LzMEXjZyNbjD+yZfruuf9jeZSAawEo4Y27LAFmJTZEwyux36k4cBNVhmz90Q+MK
	NGJSyQ2O5Dv983CjTLF1X9hNGKK8ZmFDxPW47ohmSbsk3aAZumt5TDNK2S1Oalok8CpqB8
	BCp4bSujIKd4PRfopT9Icnskp4/uRSo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-frlez6GFMbKKec00FYGEmA-1; Wed, 21 Oct 2026 16:34:57 +0000
X-MC-Unique: frlez6GFMbKKec00FYGEmA-1
X-Mimecast-MFC-AGG-ID: frlez6GFMbKKec00FYGEmA_1792600497
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4870142f030so592196f8f.2
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792600496; x=1793205296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ECp/hbXKODoBvFc0/qb2x8sXCeuzeA2bzCGlNXK2xA=;
        b=lcvk7lLxtE8/vVGpJYch4YRdyCoAKC4Fwq6XFm2SYg/HqNK5l1BgnI+sEJt9jSy7OY
         0sw9XQhNPn1ULX/+W+ZkhhrpO7VQOLiNY3mSy6IehJQOlxJK38PCNyigp6GJqlDzpDpd
         4yuWK50wYlvGp91FaxcR9IGgBBefoEvyQkuV4dwRJsENIjj5t43G9suHURMnsQQ2OMAu
         fBMWjo8DANnKZypajG635zYuT1n0J5piGwOd+jR/5CPBkUwtKMznoRzUDder5A1TlQ5+
         qfTOO9+i+ObfVAdL7uSdSzAO3zyjHd9NBAJI7RIrw3XGW3HI8nqclVlCRq7YFXqyVH/I
         4iOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792600496; x=1793205296;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4ECp/hbXKODoBvFc0/qb2x8sXCeuzeA2bzCGlNXK2xA=;
        b=EAc21xJY6R4RYjFviKqnc09JXDDw2bakn/Umdlz55sCYdjelFap/7BkDTerO2FqFGn
         KuUtgzF4p3Pwc/XKjZddZU8kJruf21CjO8E/ULNtRvRPdY4iEZ7QnIEAQJUzH76PU0Uw
         rUsiD1OP+3NFQp/E19iAd4TsHrmZY+IUPa7OMMJIPH5WxOJvLAdeola/tJzxxYaiErqi
         TuTu7DBCQhG+Uo9OoB3PqEWL9WJVzGfBgMlufLhYrpuCsy5CciQJBbx1YUJSfWzfUbHB
         k8NUZrb9SlOaX6SqjTCtFLqi/LzINiRrmzXckb7RnBkjg2ksBbfjj9Ft3hiezsK6n8Kz
         MLxw==
X-Forwarded-Encrypted: i=1; AKwUvBwZooQ+fkGseCxfvfgJF7puNJDbD7PE7KQ9+flFSoHnzW98IyTCk3w05JQ42I2KwN72LSjZIKXDCi8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwNXZ158OF4J2CsDxyfiumxgwiRJzSw3Xne9XohQRAVCrjalZe
	3afDURpbttVg0Q/nT6Eld1Wwqe2d4M8VLryAId1b3uzR2V/RgusFBVyqMnPNCH8nt2Gyzj3t9ip
	KPdIfMxrstBH9RQveJCRwu/EBTfkjVBvTHesazwrvSVTQl7MVBrfEpb8qWIWH/KXTYWPDpK69
X-Gm-Gg: AYBFou3v9WTqtoKJOK35QPConrpnPvwvYrkitK/qoowLr0NlbxVURTZFd5SgGjz9QVk
	2M4VTnqnmZfQrJPaCx84kHUAelml6c7OOsdtfGFhKihQbOHsbnWms8YUYrv5PxFz6povsu4aJzm
	Eu6VUVyTYZtIUH4MjwxhL0rA40/MJbRSs0dZQpUNC/xDU108ZShn/6vm+pihPtZZDAEPEs7her8
	rf1+NLyLNGYVOrHAJpGImEF5fRod/bfMrWEs5oss/WHdJ76dSgekqYyw6K4kWFS7hKgH3x+FIXc
	ASNase4qXK8zpXclfWoI+TEfIshozJVu22DUOjlKIHWUza54itNU9LNU82zT+Q+Cd9Ka5O3ZYTP
	s5jbk2Q==
X-Received: by 2002:a05:6000:98a:b0:48d:f957:bca4 with SMTP id ffacd0b85a97d-48e264dd014mr5155056f8f.44.1792600496578;
        Wed, 21 Oct 2026 09:34:56 -0700 (PDT)
X-Received: by 2002:a05:6000:98a:b0:48d:f957:bca4 with SMTP id ffacd0b85a97d-48e264dd014mr5154998f8f.44.1792600496077;
        Wed, 21 Oct 2026 09:34:56 -0700 (PDT)
Received: from storniolo-redhat ([130.25.253.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25828e54sm6785554f8f.27.2026.10.21.09.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:34:55 -0700 (PDT)
Date: Wed, 21 Oct 2026 18:34:53 +0200
From: Filippo Storniolo <fstornio@redhat.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Urs Thuermann <urs.thuermann@volkswagen.de>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-can@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH can-next v3 0/3] Introduce diag support for CAN
Message-ID: <atjoNSuko42e4sF7@storniolo-redhat>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20261020-funky-buffalo-of-progress-fa4bf9-mkl@pengutronix.de>
 <d23196e0-6307-458b-ba31-15f54ef46b73@hartkopp.net>
 <atfFeR_OEaWrcQSS@storniolo-redhat>
 <f57ebd74-4a96-4954-bf03-b54f2a46ecdd@hartkopp.net>
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
In-Reply-To: <f57ebd74-4a96-4954-bf03-b54f2a46ecdd@hartkopp.net>

On Wed, Oct 21, 2026 at 10:35:31AM +0200, Oliver Hartkopp wrote:
>
>The example does not solve the question about the port number having 
>only 16 bit.
>

Davide says:
Actually in ss, the port values (lport and rport in struct sockstat
in ss.c) are int.
Moreover, the port field in ss is been used even for things that
do not represent a "port". 
For example:
ss --packet -n
Netid Recv-Q Send-Q Local Address:Port      Peer Address:Port
p_dgr 0      0            [35085]:wlp0s20f3             *    
p_dgr 0      0            [34958]:*                     *    
p_dgr 0      0             [2054]:wlp0s20f3             *

when requesting AF_PACKET diag, the Address columnn contains the
protocol passed through socket(AF_PACKET, ..., protocol):
- 2054 -> 0x806 -> arp
- 34958 -> 0x888e -> pae
while port column contains the ifnameindex.

>If someone uses 'ss' as you propose will there be a specific support 
>for CAN?
>

At the moment it does not exist but in the future we might have.
Normally, when somebody adds a diag module they follow up with
the a patch for iproute2 (therefore: me).

>And what happens to older 'ss' binaries when used together 
>with the CAN diag support?
>

Nothing. Old binaries won't support it because they won't require
AF_CAN inside sdiag_family in the netlink request message.


The use of the couple Address/Port in ss as far as I see is arbitrary
and for this reason I think it can still offer a bit of support
when asked to show open CAN sockets in the kernel.

And in worse case scenario, it would still be possible to write
from scratch a userspace program that uses CAN diag and show
open CAN socket stats in a better fashion.

Best regards,
Filippo

