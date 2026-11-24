Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513612;
	b=rzpGdKfjUB7XbslMaMljc9X7FCIQiZ1Ho4beZN551qCy3FLw+sGg1BuqiY87aQFYuxd+
	 YXzoNeDfKo+z9DRNXZtPvqNCOZYWYQXA0URwuEo4FhmS6q8rDYgzxRaPCQwmYvsBwu2D7
	 k1jxbfPX2JglZVYx6PXCqvCOIiyVfsNnNVJK6nswzSQMid887inqb3vujW+YmZMxMVc3F
	 Z86OjLM00MyyF4S6MYnuLd1NA/TtIT/PJwlu8cXhfYXXTcAqMDoBythILQ4hW8TTXS688
	 /zP+cOSk7rydh9c42zXVNV3S+s/e9PWjByHPl5aiN03Mm5eBo3cu/+grH59UbJV3ftQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513612;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FmxrsBib9iuLSuVz61v5jS+I7U244zdlFXDRgzPwMzo=;
	b=3qT899Ymy35ELoJORauGrcmpdm0ge+q42R1/PIoikUD4UBkeFpPp49gcWg2kMbwHVzTm
	 5uR3AqY5pDs3VWUEiIGn+f1MdMwrm0jyRfgrTy36jbi6hJL41gCptVHjGk4isnRBRzGqm
	 lEBjcsgPJkll4nU9QoYP3rA0qsvgQdcOPiYc+rUjs0WVbrd1XPINWwy/2iLPwTB/mj9Te
	 QQp1rToEOC2DJavpBGVdTOtJEEcSdAInHd0JDT4y3yeRPdILjDetMhsQjayG3mufXbJpp
	 vJ5g4uiC83CL3n/C+OV0d0lt2A+oiz+yHrNuYqQ14bj5gB33uw0mbX9u5xsTZPyHBig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hboXgNLZ;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6D6078445
	for <linux-can@vger.kernel.org>; Tue, 24 Nov 2026 09:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38C6D6078445
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hboXgNLZ
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so28757685e9.0
        for <linux-can@vger.kernel.org>; Tue, 24 Nov 2026 01:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795513602; x=1796118402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FmxrsBib9iuLSuVz61v5jS+I7U244zdlFXDRgzPwMzo=;
        b=hboXgNLZgKjN7PRnGQVfwjqn171NGS8iZSbCljya8EWUYxW4kkVqjAsipEV34d9j4h
         z2ZdsfKEocKYHjvXk//uJcsdatvYjK62FENhg5eSbnCbDlTs1btXNrijnC8KIryj442g
         TSgoBxwSx2xSiwAYs/im+pJ4A+IBmnhEwIqNxP2x9AnOch1cub2rXEx7tRDYeXSLY49/
         rvL/Qz5qEP1fHG84OJ7EmMxb4u4A/vixczrjALNuqjwoOEgFyto3ID5QHpgPMQQOukBD
         s4UQQA6KclnzCLRygiC4qr79wQ5UjexaWEAPW9v3kcH4C/l18XuUKUDYlYAKkUVirsxK
         70SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795513602; x=1796118402;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FmxrsBib9iuLSuVz61v5jS+I7U244zdlFXDRgzPwMzo=;
        b=xvMk7/TFiQBg/gpvwFgUA9E+l2fqqZvkeA9GQp44mojq45xjOm2siJCkm6ZBAwptOK
         +X0hNHz8Hldam7d2MzeWsKV1IRbKVIOUy1kIK3/wEA0R3s2B7IqpRkUaRxVlYCg5iNqu
         DPILceZat06JB3UWDgx6xd9BY+W5VqNYu8Gcy0F97c8zkSuEI+W3pb+oxwHfc2LEDdRh
         BWTkT3wMoRQooxVWtg5Lokmkf+AGE36JL7Wfv2Mnx7jr8soVakPFha5aYJwZuNl66u+r
         LXIj5tDJ5Qjts5DdfVTHii4ivvE+co7I/BRp4SLbZK7il/LqDo9FncG9+JEzQ1oyusJh
         0tQw==
X-Forwarded-Encrypted: i=1; AL+hErFEFpmELq+K4wtPz6BDYpgL1hjLL1lM6YbrEOdjj/VRSIbNEwZM+bKaj6lq/XT8ee+V4Iw7qa+okkM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tUrceEU6k4AKdqcygOTADGrLnanS33LgTyfYqe7+/AHy1WWhx
	QEATNM+fDagtmmlgnNAoHY4YOYgn3Su68DpDuDoGgOWnEOHeDMJxn5DIRGSxC5Ts7A==
X-Gm-Gg: AZFdTZc9LdSDB0DOTnY9jSvpNt0d/AlCDlLKZonAeHKeyTZwsX0HEPh0ZG30/lqjRr+
	fLRi2XhRnS4WdXTkbzI0sBe7kNI1FwWc1Ro/j5KPikGPLj7CFZ/RAdNRbrISFt+ycz+RqEtISeu
	3IGcrOrNc8oqzumnYALz2/RuRR+D5oLhyRM1uC4cQYPl46hwIIyl5yqAQIkDAYncR0bE0gsN9+2
	LcouRWN9CDL2CIuomYJckTh2o0wX4RqVskKdys/sWKjEFUFd0JxsmAsQAZRc7Gt+s1fVYiZzoUX
	PXmaPDxkA2FQ7Kq3MAhtbYU1LJpdJAmsfX3s9HNXj7mox1IUVrlyn/cGubDbgndklM+NGiq4KLV
	zakYmO9k9Hmqy9NOZrd/r1EQde+TREWxkvE9KWDbTbZfVP3SXQmZof+bhDenUTTLh3FzOydhOv5
	iqiNN/tt2tcfDPHhe6zsyzJFYLdEfk7zq/p0jS9yxnrubtG2sih3bqX2m/dXpdXzunf0l2GXH7T
	RGStjvllh2ginL7Djv6ea+Bo7/ZlPKi/Bx2ReWkNSEhQ9hpb3Ug4+QuvWfLy5jyHhaxvB5X3ug1
	qNEzurG7TY1NkPXCTlB+wpK36VorxtPjMNs9o0afijgqUhgSNUR98H+5yqJqnZ7m5w==
X-Received: by 2002:a05:600c:3ba9:b0:4a2:1050:aff with SMTP id 5b1f17b1804b1-4bb8881c741mr334200165e9.6.1795513602108;
        Tue, 24 Nov 2026 01:46:42 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm28365466f8f.11.2026.11.24.01.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:46:41 -0800 (PST)
Date: Tue, 24 Nov 2026 09:46:38 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>,
	Eric Evenchick <eric@evenchick.com>,
	Maximilian Schneider <max@schneidersoft.net>,
	Wolfgang Grandegger <wg@grandegger.com>, kernel@pengutronix.de,
	linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v9 06/13] can: gs_usb: add support for context
 analysis
Message-ID: <awVc_pVaCbL1MEZ7@google.com>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
 <20261121-gs_usb-fixes-v9-6-db121d488945@pengutronix.de>
 <awVcnlkUDarUx5Y7@google.com>
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
In-Reply-To: <awVcnlkUDarUx5Y7@google.com>

On Tue, Nov 24, 2026 at 09:45:02AM +0000, Vincent Donnefort wrote:
> [...]
> 
> > -static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(&dev->tc_lock)
> > +static u64 gs_usb_timestamp_read(struct cyclecounter *cc)
> > +	__must_hold(&container_of(cc, struct gs_usb, cc)->tc_lock)
> >  {
> >  	struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
> >  	u32 timestamp = 0;
> > @@ -1037,7 +1040,7 @@ static int gs_can_open(struct net_device *netdev)
> >  		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
> >  			rc = gs_usb_timestamp_start(parent);
> >  			if (rc) {
> > -				if (rc == -ENODEV) {
> > +				if (rc == -ENODEV)
> 
> Could this make the series non-bisectable? 
> 
> >  					netif_device_detach(netdev);
> >  
> >  				goto out_can_rx_offload_disable;
> > 
> > -- 
> > 2.53.0
> > 
> 
> -- 
> Vincent

Ha sorry, I missed the v10!

-- 
Vincent
