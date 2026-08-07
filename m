Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A294756AE
	for <linux-can@vger.kernel.org>; Fri,  7 Aug 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117265; cv=none; b=qu1hHKPZ/bBttrG9hPtTa/GGWv6zPzc7GLYC125DELWRX13mgsuULk8HI7FZj96EQMTjVrrm6AXt0FkOYtYeVzIL+9X2pe8Aw2WN2wULNNpWz+ukfoL1eHXepuKV7BmMRK1SyloQWj3FvJy1y7X4ekzL3LenjkKTRclpTS6XmHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117265; c=relaxed/simple;
	bh=5lL+GPVEajvcqlKFJHd9Lm9sPfU+I4rtwlMhLnHc8dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMsxT8Bm+plr0minb7YhkLnVV9aws+PB7o57uJmBXLBAh+KUaQpveeuWn3C5Ke+o+1I9W9qJoc4T7G/B1wWFe941A7wN1Fn9iR1NQ/qyle/riV1FhHo5ywH3OH8Lkz28KPPfo+b3TBnhfxHspdiRxZA7sE5F8yyYTgMS9w+jNxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWG0dXsx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O4NgHBeX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWG0dXsx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4NgHBeX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786117262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fenRIcDGusm2XgEsmBMSb551oLPQ5HSOnoRBDqBoOk0=;
	b=UWG0dXsxmCOHcNW8ud3qr9F5e+zgFLIaRtd5u95poqjQjRRbtlAGZMm0ZxG0uB5knPir9F
	MnSQ0sZHEbEFQiJWT9Ba7NidaVmRJqcKEHJ7rCStm5lN5Dh+14AQpMV1eHHIfyDztAa5M5
	nrwAf8mcpP8AasJsqaI4pMWDLhKyWc4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-4kB9gGFCOdWEueXhQe5CvA-1; Fri, 07 Aug 2026 11:41:01 -0400
X-MC-Unique: 4kB9gGFCOdWEueXhQe5CvA-1
X-Mimecast-MFC-AGG-ID: 4kB9gGFCOdWEueXhQe5CvA_1786117260
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f81362fb1so2153301f8f.1
        for <linux-can@vger.kernel.org>; Fri, 07 Aug 2026 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786117260; x=1786722060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fenRIcDGusm2XgEsmBMSb551oLPQ5HSOnoRBDqBoOk0=;
        b=O4NgHBeXjZgGRiqGMkuhLjeCXSiZmmUMnUcvj0ce0j9mfvef384DAdk9nbFO/8/eWb
         3iFxV596v7uAFVNwQPzgUpT4dVQLDTAlRpGFhKb17vn0Qz2cOTn+nFh4giu5pRve0apU
         lN+T5lFkBPWEC84mcusBF0PJH/X5hR78vpVhCVZv8TFOMOnfVICatag8OdzUp909Xnko
         YT6oaTZZfMFLl0U+2d7xjTpMxbGqk1S7P3rGZ04hc+Zr9ilIbPm5qrOtV+vCcZ41/5BA
         8wicPVl6l0oPVQk6ORtsndHPoXozG09B1+yi8T90l7Hi0tSJ+0caMpOZIRYJmtKwbjcO
         ZMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786117260; x=1786722060;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fenRIcDGusm2XgEsmBMSb551oLPQ5HSOnoRBDqBoOk0=;
        b=V7N+inUZ3FTU0lRu+W1RSXurmE7PEhZsOBOIjUxFHAQO02GLrc7OWpIVN/S8+20CvH
         ErstpEMVc/Cor9ynmW5xETNi42joRGBPJJdnU1gLarZdWnAF7JlFlTYPjSSP2QAIg6Rs
         DEXWq3wOigrNd00GKdrqyuXlFWWFA4YVwoLRQJIKkXUeZAtSbD/iOpcE/GVPuz+4D66l
         NggUVGo0yLUaQEt1Bh7MXSVGUquxTucEt+xGNYXuXNBi+mhLOghfgiznvl+vpEv7nWJQ
         6yQG+2Mt0dgmM2FKvlwFvFIby+VT0AOoKXxaRlrc5j59nC6WRj6YfV0sViFzDXE/lm4Q
         gM/w==
X-Forwarded-Encrypted: i=1; AHgh+Rq+TQd2fmNqRxtlYWxeGaJpaLyKVONb+Kzt/Ruq7GwKvEkEoueBPWPxmBggMlYJPSZq1I9xUlJhyNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfdB2dbkguI8OR5BGX9Sve9CRZl4xvovAf+CGKOCBBegTyiCiH
	Jg2AkcnSHum+7hjxtpLYRLqEigAaWPsb51HXAABrm4to55DUY/64mUSE4CuPdYgt/jj6ooMhC8b
	48amGKRxuugF0U/WG+ff0wlzWJdJrP9iz5D4N+AjSpCeodPrK0qousFheT6TLhSwWNvI4jw==
X-Gm-Gg: AR+sD139Q10Zb7sZQRHg3sy9xUioi/eI+H0olTZrX40uK4+ysd42xoni6KK4+Cu7RsN
	43XCVMPA3QkDEnUhPZCT2Mg8DtLpzb1dXOM8M/R0fgmPCCLbN23tDUb+ORALhTpZbjHL9vWIdlD
	B5eRL7NoJDxE6nr/GJDhfxOnbb5Gqa21bC4GxDwVH0IwkC5Hgx3/LNbQGcXUnPMBYiopy0v58My
	cvF/5Ves3/9I2JNoJMyNH0APwlVA0BppxFus978pwz2X7Gnak/geNgbB0+6GhJ1HRxL7PTqWF2X
	Z/X+l9M53ixxU/jl4nqeNOF4fCdj/ALJYcvIPuY04w57rg15p/wstFW29VqpSXHiODj5JQzju02
	dR0XA3diSXXJYKYTME/KtE30bSW/BfXVZFALyD8aJylfZxiEw
X-Received: by 2002:a05:6000:29db:b0:47f:e797:41c8 with SMTP id ffacd0b85a97d-47fec4e8f84mr29284469f8f.4.1786117259848;
        Fri, 07 Aug 2026 08:40:59 -0700 (PDT)
X-Received: by 2002:a05:6000:29db:b0:47f:e797:41c8 with SMTP id ffacd0b85a97d-47fec4e8f84mr29284412f8f.4.1786117259353;
        Fri, 07 Aug 2026 08:40:59 -0700 (PDT)
Received: from storniolo-redhat (host-87-1-27-205.retail.telecomitalia.it. [87.1.27.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm6755611f8f.22.2026.08.07.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 08:40:58 -0700 (PDT)
Date: Fri, 7 Aug 2026 17:40:55 +0200
From: Filippo Storniolo <fstornio@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: sashiko-bot@kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v2 3/3] can: add can diag interface
Message-ID: <anX6z1hyroHe3ExH@storniolo-redhat>
References: <20260806-feat-can-diag-v2-0-832597ee4cb9@redhat.com>
 <20260806-feat-can-diag-v2-3-832597ee4cb9@redhat.com>
 <20260806135125.343781F000E9@smtp.kernel.org>
 <20260806-ruby-raven-of-elegance-432d46-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260806-ruby-raven-of-elegance-432d46-mkl@pengutronix.de>

On Thu, Aug 06, 2026 at 03:54:48PM +0200, Marc Kleine-Budde wrote:
>On 06.08.2026 13:51:22, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] Netlink UAPI attributes embed binary structures with implicit compiler padding
>> --
>>
>> --- Patch [3]: [PATCH can-next v2 3/3] can: add can diag interface ---
>> commit 98771deaa2e2d4a790b170eb8967f6122234dec8
>> Author: Filippo Storniolo <fstornio@redhat.com>
>>
>> can: add can diag interface
>>
>> This commit adds the can_diag interface for querying CAN sockets from
>> userspace using the ss tool. It defines the userspace ABI including netlink
>> request and response structures to expose socket properties.
>>
>> > diff --git a/include/uapi/linux/can/diag.h b/include/uapi/linux/can/diag.h
>> > new file mode 100644
>> > index 0000000000000..7f99f85c42425
>> > --- /dev/null
>> > +++ b/include/uapi/linux/can/diag.h
>> [ ... ]
>> > +struct can_diag_j1939_addr {
>> > +	__u64	name;
>> > +	__u32	pgn;
>> > +	__u8	addr;
>> > +};
>>
>> [Severity: High]
>> Does this structure introduce implicit compiler padding? With a 64-bit, 32-bit,
>> and 8-bit field, it appears there are 3 bytes of implicit padding at the end.
>> This can lead to architecture-dependent layout mismatches in the UAPI.
>>
>> Additionally, modern Netlink design rules strongly discourage passing binary
>> structures directly inside attributes. Should these structure members be broken
>> out into individual Netlink attributes to ensure proper validation and future
>> extensibility?
>>
>> > diff --git a/net/can/diag.c b/net/can/diag.c
>> > new file mode 100644
>> > index 0000000000000..e9132ba3f8cc5
>> > --- /dev/null
>> > +++ b/net/can/diag.c
>> [ ... ]
>> > +static int sk_diag_fill(struct sock *sk, struct sk_buff *skb,
>> [ ... ]
>> > +	case CAN_J1939:
>> > +	{
>> > +		struct can_diag_j1939_addr j1939_addr;
>> > +
>> > +		memset(&j1939_addr, 0, sizeof(j1939_addr));
>> > +
>> > +		j1939_addr.name = can_addr.can_addr.j1939.name;
>> > +		j1939_addr.pgn = can_addr.can_addr.j1939.pgn;
>> > +		j1939_addr.addr = can_addr.can_addr.j1939.addr;
>> > +
>> > +		err = nla_put(skb, CAN_DIAG_J1939_ADDR, sizeof(struct can_diag_j1939_addr),
>> > +			      &j1939_addr);
>> > +	}
>>
>> [Severity: High]
>> Does sending this binary structure directly as a raw attribute prevent proper
>> validation and extensibility?
>>
>> Once this ships in a release, the UAPI is frozen and this layout becomes
>> unfixable. Could this be changed to send the individual fields as separate,
>> strongly-typed attributes instead of embedding the C structure directly?
>
>Sounds like a valid point. How is this handled with other diag data?

Hi Marc, thank you for the review.
I understand that with the new netlink guidelines, passing binaries
structures through the netlink message is discouraged. 
In the next version I will change that and I will send the single 
datafields using netlink attributes.

kind regards,
Filippo

