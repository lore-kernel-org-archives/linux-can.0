Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F903D813C
	for <linux-can@vger.kernel.org>; Thu,  1 Oct 2026 10:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851351; cv=none; b=nwsSTjQ6WCJlNiAViCe2T60kF8fqkn3zLR+Q4kAAMKRqNj7W/S1mkTF1IFB6b5Rho0u1R0LfTyxzhyo/vnx5N4RMOvx3H8lGmT/UP61UYBLNfRT0E5Qmin9jL/8Z2pCGpwMcochg6CJBhLjSBrbBxHsbrAZ6KIpa0RB1uJ3tb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851351; c=relaxed/simple;
	bh=lQZTDSIHL00paX37Uy1dmIWO7Foaykj82cQvGVzut+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHgo8uetdsEsy1i4qvJD3uOhINpavRnrX+FZXL46xucvXw4ARfqRK1b4VEGb5P2IuliTYzSWyu/VM8V9Cqby8Zizuda3eHWMzmOS5zLDNN/La1tU1IzIiqPkHrt0kXKV2XqNHkfCixY4nScXZqkX2+KG66doYF3WXdpEOudGAe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nC2kfYEF; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nC2kfYEF"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so46794905e9.1
        for <linux-can@vger.kernel.org>; Thu, 01 Oct 2026 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790851343; x=1791456143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lQZTDSIHL00paX37Uy1dmIWO7Foaykj82cQvGVzut+U=;
        b=nC2kfYEF/Usos6OjjH1MgnFunuUCnpr1MwnO4/lS1JlUW0eEmL8gfsM2ZSkUAlrMQn
         fTXWpt+gYV074DEQWAa5CsMT6KLmwNgh2Mn/RdacSGX+hm36/9RsZ/gACkmPMW7WVpzV
         K93jzjrEl5KrKujCm8unrA89z/b/BwipQlVPHHT1Ye0XRjOhg7afik2UI/kMluxrdXeC
         A4iH5FDby7tuLOFWfUsj03NDMdK0WAQoo/xI6y1HRJLxo1GNJof/hej/fbNJbdzo6MoV
         MGbkzL5o14TDubcOXORgF81z0hGMKEZyYgzH7wptahG3/xjnmrdgamxsO0SndOf0z65Y
         fGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790851343; x=1791456143;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lQZTDSIHL00paX37Uy1dmIWO7Foaykj82cQvGVzut+U=;
        b=T6JYBWZWD+cdW+UgKJLkp/CXtpxeVC/TP/xO1s/j50rJ5ms5xt2Tcp6lf+2ZASOUWi
         zm+7rvnXVCsgKm2qfSFgLLcUCER3qbkVrbyyuaK7xcVlXnvKVmE9Hu6SLhAc7O03bpAG
         zhlSWkiHvecwIt80FdbZBg59K9E6akuIoGjwHw8bFPAwAO5DXssDMSe7cxvxDJIPXmF9
         RyhBLyRvoQR+yy0B5EGCzHXdl+WERSlltHb+KworVFHCFkNVmTnhv+DJp8+tEi2OHcrU
         B0ghoo+s4LRUgaSGpcd+ZUVIDdJ6vjrdLuhAKaN0uFrazS7MYMuMpKAtznzhVfxIpOkB
         STFQ==
X-Forwarded-Encrypted: i=1; AKwUvByAbUpANRedmcVHofzCEw+pyGfNsSPL9YuPXkys+WHVC4P0ZGb4q9VerwDDl/1+9akSLQhdIfGwMdo=@vger.kernel.org
X-Gm-Message-State: AFuF++kya9/pdJlzNObFEKp8Y8l0KmGr7bb3g1vLx3hx3YjAw63BRFQx
	qoPF5Pn/ltjf2g0arQi08BFPQJ4I3X88M/btvwH033HL+wCwyCyka2BD
X-Gm-Gg: AYBFou2i7ivl1dLn/LkWJ4FprU28d43iJWaj+2M05fhimJbOtKIocNVSLt/9eOPq52I
	bZnQlQ5B1+5X1VzZ8ku5tkgIcVWWtg4xVSZLM3F+nE718r7cLzVh3W9MZGfs7Cr3nvAPicodx62
	vTJMa9gwdLFLgxEwkWSPxadWYNUGuDC9p5bqFzK5HSgBeF7F6NY+S6V/rakqMBPnuS/rGUcZDSM
	6q3L3vvaeCjso1/BYthoEe32Arm/h3EdRkuGvqvOpCcKfZTctSSl6YPwbF3FfR3vScDgm3O0xCr
	nY9yz7OBxdPe6OTrT/yeMH2HxuG3wEJ2L+0ICdtFdpIkcfLP0v8QwoSWaLxXT29t9DbuNSbg6CN
	bclvrhJiqG6vcy/nAuF6oNXm8wxai8BenQSVscncfrZcvxv84w9aURhL3yubx7n+k9agTRU0yNV
	AeMQRjniOH4IL/o2AHrz6c2ih0OZvlsb5vSV1QqLEkKnEsqtgZc63n3qNjve6UJnUlis9eqP0Zz
	AxF030=
X-Received: by 2002:a05:600c:4e42:b0:49d:2450:68ac with SMTP id 5b1f17b1804b1-4a01afe84a4mr73565895e9.5.1790851343345;
        Thu, 01 Oct 2026 03:42:23 -0700 (PDT)
Received: from LEGNB0874 ([2a00:79c0:ae4:9d00:1f4b:c311:c1af:96c9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f923320sm63394605e9.7.2026.10.01.03.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 03:42:23 -0700 (PDT)
Date: Thu, 1 Oct 2026 12:42:21 +0200
From: Markus Koeniger <markus.koeniger87@gmail.com>
To: Alexander =?iso-8859-1?Q?H=F6lzl?= <alexander.hoelzl@gmx.net>
Cc: o.rempel@pengutronix.de, robin@protonic.nl,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-can@vger.kernel.org, markus.koeniger87@gmail.com
Subject: Re: [PATCH] can: j1939: fix potential race condition in BAM
 segmentation
Message-ID: <ar45DX0aPoWBvA_-@LEGNB0874>
References: <20260610090619.70626-1-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610090619.70626-1-alexander.hoelzl@gmx.net>

Hi Alexander,

I really appreciate your solution to schedule the TX timer for a BAM transfer after receiving the looped-back frame.

We use external CAN controllers in our system, which introduce some jitter into the transmit path. As a result, messages were sent from time to time too quickly and violated the 50 ms minimum interval. Your patch solves this problem.

Tested-by: Markus Koeniger markus.koeniger@liebherr.com

Best regards,
Markus
