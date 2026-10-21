Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792581611;
	b=TFexSOUw0u6iEH8DgU+7gfKqsTqZOf/8OwI/dRlqQz2dV/M2kpgawPWMbuPKPmN+7K1d
	 zx9F9hEicBuUmTfkchM/kG4oEEIcGbL9srOv9oprUn6SzehmuzuCZMasGz6vJs9oLKEjv
	 QDoLle5iRMKEAVjFrtq4X0xoM7Ktx5oDEkEBmHqKKjLhaq7c3lLHnWW8kV8+S4lCbXy37
	 pi/LodaMZHSY1EOoEtHVpmuV7NbBg/BbNjQJkvHbR8eItbMoy+CIakhQqAa2h88+58wNC
	 CiU6BrMS69204tgTs1Yu+qfQINcyA+LaVPe9N0UpgvS0LJWWRhRKY17ygE3s2MlnGAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792581611;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=w5qHsNBL65JXSuGYZcD4Ld5r7zaKVLOfeXV37O/9Nzs=;
	b=TOHaFo6ITCKO5IFMF82GYgL5iZc2Fva/Cjon+kh2U8VJmKwYKyzQE0iNV+du3RVEJRLA
	 RT8pS6+fRGCFDUjdEakKJUZosyq7jO70asG7gscy2gHe13779YMM9nB6DQFT9QOuo8Qn0
	 UThjSXC6sOy7DOgzT2PtO+DQZZLxlIhGZlVvZc2fO1Yd++XKMPU71AQjSK+cdUZP3ujRf
	 /end9Ph9WSjrkdOjtkTzNNWtCOIZLRABf825a7460rYIeR3s7mcX1QJK5cdB+bHlkuhhR
	 owfHbBEH9sb2A7CiHWhHZ6+VeLPg0uM0K40YkGwDKWvfJdcXugRI3UVyP2HmmTNzo+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BWRgO6LZ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XwTvSYB4;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62E606A321
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 11:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA62E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BWRgO6LZ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=XwTvSYB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792581609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w5qHsNBL65JXSuGYZcD4Ld5r7zaKVLOfeXV37O/9Nzs=;
	b=BWRgO6LZFei8+iDbqTXT1QpJQN06VdsZleBWZTpPbmXnVeM7qjT84iEb1V/Pqg2NcSp9hG
	3kfDwMuouDQnGM43bwXQq7d4PWQzz8zFhmYbhLlbfs9mAwLDL80Xfjs0e5HFkkJ4QFYo0x
	Vm1XcNaJjfZUIP7YrtzAkwI/VEpJCpQ=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-YtvQ2Le1M6WDnNZn2eDntw-1; Wed, 21 Oct 2026 11:20:02 +0000
X-MC-Unique: YtvQ2Le1M6WDnNZn2eDntw-1
X-Mimecast-MFC-AGG-ID: YtvQ2Le1M6WDnNZn2eDntw_1792581602
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eadfb67611so138227e0c.0
        for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 04:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792581602; x=1793186402; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w5qHsNBL65JXSuGYZcD4Ld5r7zaKVLOfeXV37O/9Nzs=;
        b=XwTvSYB4U+h/1fZUmyzfm0Uyywv7yMCGHinDDSATd80HdYXOPuR5M/WMmqXN7SlRm5
         Tq1YcSPP2zKDrEiLmrbfgT6Ubu4dzuWXd6Cpbjundlh3k07YAcWqbEYOzGAh/6ONmtb0
         1hE9kjxCyKoWwulReIWyw4vj+TPydcq6DHspY9A2nBnYz+rr4GtUWHSqiUGRqrn8+drs
         UynU8UMa6N2I4rDdEMxWRpb8GDqRFK0bQyfuGvwWwi9x37dLZa05xsT8oGvTItW2ZKVJ
         BRbmGeG+X+L7CWrBGgzcteQMYJLR+EBJFeButojohegGCShCyA6TaaoUcsdD232WYb2E
         VGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792581602; x=1793186402;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5qHsNBL65JXSuGYZcD4Ld5r7zaKVLOfeXV37O/9Nzs=;
        b=agAON0pgIv0tGNY6HZDcfPru7hV4lIzG086uMeDd5olOeYK3Ni9ZRaYlVqFDWP4S7P
         9SkY2XKF6p2xBD2N6/6Rrow1kgTmJ/X1E16tc3va3S45z6YSSJpM2VhmqPPW9MvRhl2n
         WFmyt5lWbE4ImFYPGLSRmu+EMlARC22jqGurfzMUcCsVCvta5LsA50WIxB03W8TvGnDs
         5h1VsJbf6T8uis8mBs7Ivqtj3NXe73EG0ghBTPGpRiBFYdSjCmDhX4g3AZfD+EO/ZHqk
         ymGyfKgNvEsk/BSBeFVkD4YWFXRDnXzbpwUYAJcwYvMIAQDOZUalu9gb368LaxQf/QU/
         Cf+A==
X-Forwarded-Encrypted: i=1; AKwUvBw3CZoeKgnCiZidqqF5G2h4/EAjfpqzjFoRSwtjT7DEgUSVJ0HURuknbTSR2Esa9MQD2PXRlU/IutM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKecRgppqvxJGCCgoeUE59OAzIVPjXJWcBWYBpv6wt8afbJF/pQ
	N7Zljmy0Y3VIMdujjrjeXkV/KYBzStjxmpxylAZFtHqIGWsy37Y9EOo1LjzNUFwZc0SLmnHmUsd
	SHispxce5/k4MhAZ0wX3OiY7ZyjG4Hr/3rTDG2gklHVobBzhKKjmkF3fTShYZ8w==
X-Gm-Gg: AYBFou0G5XhUI+WEhCs/eLNCQHx5ZT5818FWJ6XSrciPMYfulhtbTrHDadV/Lsj+o4Q
	b/nppNPXhz4LIZUTYF2NDvw99QBgodtuUuXp3YKmC1HncAj8+NLpKn2jz2854DfORNvouM1XJsv
	Dnb+/I3Xpbkn+hhlo6gZp3oXAQFoodJglg3SFAWKXoJPytXdy0lC9MAqYu4oeJRbGgVVLjVN8uj
	ADFV8j4KW7SupGncu1hryQU6oL8I35mgWubIx3PqcJMz607HyCVYI4XpeVflVE5l5O78DAVbR1E
	eOWy6d5uHey9OJl/xKEXSciXFxoW02R4TyhS2zzyFjCPcc5V0/lZNKoWQsXfGO/Z6tn/eroWkVj
	cVjtONtmSsWAk6ri0adNUe+41kXuWildHHyA5FM0Fj22u8yEOOas9jzflMpUjRlBBcPaHFE/vNg
	==
X-Received: by 2002:a05:6102:1492:b0:7cb:bbcc:e52 with SMTP id ada2fe7eead31-7cc922532fbmr613449137.0.1792581601739;
        Wed, 21 Oct 2026 04:20:01 -0700 (PDT)
X-Received: by 2002:a05:6102:1492:b0:7cb:bbcc:e52 with SMTP id ada2fe7eead31-7cc922532fbmr613440137.0.1792581601238;
        Wed, 21 Oct 2026 04:20:01 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d12049e1sm2688668241.12.2026.10.21.04.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 04:20:00 -0700 (PDT)
Message-ID: <313fdacc-a8e9-40b0-a125-2317ffaae79d@redhat.com>
Date: Wed, 21 Oct 2026 13:19:58 +0200
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/11] pull-request: can-next 2026-10-21
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20261021102756.1900679-1-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261021102756.1900679-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 12:24, Marc Kleine-Budde wrote:
> this is a pull request of 11 patches for net-next/main and obsoletes
> pull-request: can-next 2026-10-19.

This is a bit tricky. We are already into the merge window, we should
defer all 'next' material posted after the merge window start.

/P

