Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513510;
	b=3CCbsaAb1bFM9MrLwPW57tJr2ACg3yTsBccbalUk5TYfgc9PDTp/7nwG90wdrO6jafdi
	 NQWm4mC8lBrweDpwCPdbA27h7A20iBA0cBfOqNfcQgF8G5yvOqQuJ6aQ0fvsszCUYzX8q
	 gySm+Dsn3vlQHphXliqi6kqvjQ/GQQJZrQCeausX6fWG97ZAFNJBJ/Fy6GqjPnXejeKE8
	 9D/HB75kwEBMF51Tn41gcstioXLXuhcJPCCehqeJCQTknlR0GAZm1pMaZoRlUI83EgIeP
	 yrFQqOo1tZXfM8UxKn4BjZ+bKMJSYPSKfSwn/KTNWmWPxcOUhMIkNiCZk3SmHeRtO7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=KmJ6a4FbB34BvjQvtAwc0XL/QMaak02xhWPoP0gP7Y8=;
	b=Qa1uU/s74N0GcT/4WMCI1GDnHWuirMYnzyonMNg7zyRM4OaycQhFqb3cbaJh9H8FHlxw
	 knyivOkOX7Os/TOTY1d3e88kPu9vj7iDk7U387tqech6csrVfjPPFl3YlMlzBhedd2A05
	 Y09pLWxrli1X1W5iCtzeluFnxM6XSwDEVJ+0MqokNfh9ga/kbas1j7Iue1zbcMi8sopA7
	 /wgyN8lqtEChniGbgdXE4nRD+zl9s8Mv/fqJEUtptQy2gw8yYaFFl03627U6/1DsVQTo9
	 wcBb9wD7sPjNrTnT5faaSLzjeWM0HQ1TmKUzP0+gBMVd86436siatvEwnE/jIWHBhpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="buEzo/9Q";
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351C060A3803
	for <linux-can@vger.kernel.org>; Tue, 24 Nov 2026 09:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 351C060A3803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=buEzo/9Q
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so55004265e9.1
        for <linux-can@vger.kernel.org>; Tue, 24 Nov 2026 01:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795513506; x=1796118306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KmJ6a4FbB34BvjQvtAwc0XL/QMaak02xhWPoP0gP7Y8=;
        b=buEzo/9QfUzHpM6Hz8l2Jwd9AEHCAvSj1kgLkQLJjtD4K8HPSAjEJDaEweyCfaPN/l
         ZutWtFOBK0U8TbBdYP7FkMALlH94igD2KB8Puf+yY1rYPFLE8CvbkYiquAtsNq/Hc+Au
         jgd4XNmz5fzS44dCpItJlads2kc57xE3IhKct7s2CnosKHic6F9169VEGw+oPmHCbNr2
         g4/WKuA35hY8EArAm7Iuxcktf48QDvS9bdotyU6EfFMjF4oUUhrXcPA6U3xdYxXTzrkE
         hAzToQ7kW7kVS4CtWJd381dhzLeldYsrJSOyYNH487X+u/Bl1jadBe/0AcUJD8GOuRoh
         0IJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795513506; x=1796118306;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmJ6a4FbB34BvjQvtAwc0XL/QMaak02xhWPoP0gP7Y8=;
        b=nAGPcwGJ75kg7VtRK4+Q23H5SViE5MwwB6eYoUzTHUUHBgEXdVBJI0Bq6dMxewxvOx
         nMuM6wmami6xQn8iLSoPhJVztwaCj3tzYuQSoahCoGSrLjIqnsTRsz0JJsOTgqTE18sQ
         MP4NnP2p5sc1QWc6oiHd/hcOv/cvh4/tbBi3PuxHUjSOhY/5qTAtryz4yOQl+YkLSWNf
         HSot5XEJT6LzFk3mjo857OQW7hqRvlK0iqTh+obwh4YOmpGzQw7ExPijMItnnDZE40by
         d/5XpC4c/0VBBfxRKJT79+IM0CJOUDwiN/WrZsOOa+kM6xogni2Cszzm4AnepNIR/2Ys
         FVjQ==
X-Forwarded-Encrypted: i=1; AL+hErH3gQlIxWKX+gSuOCLH9XqNYY+uQFYT/n+HbxitN5DNdmaJEvBh6bUv4XMTCA3aDCb3EWOovCdMsGA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yXmfYFiaxBAgnzLwsnACoJgtac05gVcP8BhDLoCwFPIKR5SG/
	Gw/8XOXGc+2fGsusAQXENXHNopeWWTAFyyZuV5MGLCc6dIGEJP0lyBeVRAOuVZzJL9yR9mVlsJR
	9nRS8Auh+
X-Gm-Gg: AZFdTZcXcvjOvBrRGX3eAvHeas0jOCbw422F2K0z9ofN9Kq1PP+kF704z2LHdYxQVzy
	iX4mWP9wdsD8io/cAcilKI4TcDBsKBFSVkgaeG9CxYDEqcTiZvrgfi/HvIqdcNSqgImmKw2amHx
	KpHt1/86L5W4s5eHLX9voclprHyeGQHx+PBALXfDgd1pf4a9aosCViH1Bj3ANpUdsYX3tBBo0Ko
	o8cJoapQ/l4MdGmsEYTU/lT+gtiL2KJAPce2e/XrzHj+3E2oFBQ9jRnq+JoFdZWe/fPVKnhtlyd
	rh4R5rIFhCDwwSlxBVykfyZoSVU6XwxeX7nD1J50bN+66bFY8FIPGwY3EGU/JCA5wyVjvKY1CED
	oyX8Y6tojDwyqGhS6SP/bTkd3YI+xZ6N8y8Y+vzXHTAVtPAn48CMo0P3wNxKjtRZW8bqJxgg/Fx
	Drx9y3ZQehDKAv30aMjChEawV75anCTnWSkqv/uj9GdBGuYiaI8MGh4WKXTMTGuAq/VCpx8oicL
	zLfEAuseyAFHLngrJ+Zo21GMN2KDrUQUw7iXRERDk5hct+Q+dd0MpmKzKXu5YncJgGi3uQPYENw
	OfEe/fB/fVPxRSUjQi7c+EABYI+pmYaARe2KxJ7PSljRdUooJz5W+/VdF0yKWtKqUQ==
X-Received: by 2002:a05:600c:491e:b0:4bb:5f12:336a with SMTP id 5b1f17b1804b1-4bb8614f0d8mr232644425e9.10.1795513506004;
        Tue, 24 Nov 2026 01:45:06 -0800 (PST)
Received: from google.com (0.182.34.34.bc.googleusercontent.com. [34.34.182.0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm31372490f8f.21.2026.11.24.01.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 01:45:05 -0800 (PST)
Date: Tue, 24 Nov 2026 09:45:02 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>,
	Eric Evenchick <eric@evenchick.com>,
	Maximilian Schneider <max@schneidersoft.net>,
	Wolfgang Grandegger <wg@grandegger.com>, kernel@pengutronix.de,
	linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v9 06/13] can: gs_usb: add support for context
 analysis
Message-ID: <awVcnlkUDarUx5Y7@google.com>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
 <20261121-gs_usb-fixes-v9-6-db121d488945@pengutronix.de>
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
In-Reply-To: <20261121-gs_usb-fixes-v9-6-db121d488945@pengutronix.de>

[...]

> -static u64 gs_usb_timestamp_read(struct cyclecounter *cc) __must_hold(&dev->tc_lock)
> +static u64 gs_usb_timestamp_read(struct cyclecounter *cc)
> +	__must_hold(&container_of(cc, struct gs_usb, cc)->tc_lock)
>  {
>  	struct gs_usb *parent = container_of(cc, struct gs_usb, cc);
>  	u32 timestamp = 0;
> @@ -1037,7 +1040,7 @@ static int gs_can_open(struct net_device *netdev)
>  		if (parent->flags & GS_USB_PARENT_FLAGS_HW_TIMESTAMP) {
>  			rc = gs_usb_timestamp_start(parent);
>  			if (rc) {
> -				if (rc == -ENODEV) {
> +				if (rc == -ENODEV)

Could this make the series non-bisectable? 

>  					netif_device_detach(netdev);
>  
>  				goto out_can_rx_offload_disable;
> 
> -- 
> 2.53.0
> 

-- 
Vincent
