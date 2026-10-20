Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792514011;
	b=mU0Bm8sALdDSMw3ZDA1VJRSIdhvFD7DQvRfj/lrko1dX6TkxOZBVjiu66/Ja3GBrpARh
	 NXR9xKiZRfTfwH0t+5ILooOjhnJjVTQsswKx+IyeIkYxHUocCXfWXIhXADVLR6UIp7jWB
	 lxH2WOybt4hZvMZsL2onmkgtXtZZD2SxaNMZL1DkTKzzfQ6DqW/farzIHO8VBCmpt2mfd
	 z/56fse9g5DsIVeoa3MVelDte1tkocB7JQoHwe5mSroZu1X3Mli12klA08ceWGDlMq5da
	 aT84TUtgUwgmiAtPZxrbTFGPM8Hjg5IuDSi1ZqvJTdDnMBwRzZADuwBC8dRG9myYecQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514011;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OgtRdYhx0nvtYafb9qO3e/2HBoxq1mY/MOIHjFCCk40=;
	b=lmyE+0G7UCsgwvPkP6yl6wQe7ZdH7ScNVQ9bQ8h4yE/hN0tI8MksxEO3s/dUi06obA5t
	 fot+ldhmiyEovUCAMeLgHqxsBp0n5g5v9GHnFrOTYVI3vJeT8yPuVhlosZJ2sD96aY8TZ
	 SdWZR3YJv1Syh2+dYOn6PqDxADuyeuWjNpjPOu3pB21YaoEnYluo3Zmeph3zmPZzLN7Xc
	 9ft9Hk1e9G9g5vU8cu1zrcwXmgcix+XDtgxEbh6rNj0eR6shYKPuUADhqYYFCMSmbgcwx
	 QKitjDkrR2NFcWjv+vKUFippgKyI+rvImKsgSB2hNLMlP7CWRSF4ATDKEoepwKtl+Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I0nhtCBY;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=M1whx3OY;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4012C606A31B
	for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 16:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4012C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I0nhtCBY;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=M1whx3OY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792514010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OgtRdYhx0nvtYafb9qO3e/2HBoxq1mY/MOIHjFCCk40=;
	b=I0nhtCBYagI28Q6u4XHklpQ5Z4t/KnGK0mvtLFzrxjoJKGb5WTkjPNtM3SXzKytzC4Kzyh
	8DsI2SQggd7QWJziGLH6i0AfuEHUQCPvm+4T7Eh07VpXGopEui5H9xr0lsUDqvYR4qMdJ4
	qbYsxXNexpWyH3tWsOF6qLPI4ZvFp3w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-oYfOhM04M02fpY3FAAGlNQ-1; Tue, 20 Oct 2026 12:33:28 -0400
X-MC-Unique: oYfOhM04M02fpY3FAAGlNQ-1
X-Mimecast-MFC-AGG-ID: oYfOhM04M02fpY3FAAGlNQ_1792514007
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a1e672580aso18211835e9.3
        for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792514007; x=1793118807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OgtRdYhx0nvtYafb9qO3e/2HBoxq1mY/MOIHjFCCk40=;
        b=M1whx3OY4QDZKuc76QlVNR86Z6IhjvrFJr+I14pyXZYPljmqBtdVMC7CTBjHeKwpmO
         SjN2pkwHfuVHpQ7BOEwx6XAB4eEt2jhH2G8umorQT6Mxv8uTco+WfIR6jEw8ZRmYs1LG
         SCvsDuSJxVivUDwpcSLbNfn4TI26O/HBBl17deQtMM8fHaLNIgY49cE+/+joZQIBeoHl
         ua9vMGGevzlHzc0H5R7PzNAbokxBWkwhhsRGxq2514w3ObSgea8RRKVLr0NKXjjxLDu5
         KD+sw6EPvIEVMvqfXM78wLCyx3qI+4iZOiHcWY/BsCSWEdAEB9ZVbZy0VylPlpouviRi
         rrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514007; x=1793118807;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OgtRdYhx0nvtYafb9qO3e/2HBoxq1mY/MOIHjFCCk40=;
        b=A3UgDzXKw4F4cFtqjSA4+c2lWpqxmTOvorMcGaQbu5V7X37ulaPJ72i/+c3IRG9hBi
         ReJ3TjGnuI9wowvAFTWTAdUn4XnT28sWrAuMtWoa0ryRxa9JRL0DBRjTBe6RtIUVJrPc
         iRUwgrfJnD1pT/n0pn4fsR0prOijZvXqTNMBFt2vwgaipi44N6LZrQ8gAInn4TWvQ2nG
         JGha9Sb4rGT5AjT/rBIqrbV33B14n9uIFOIGXCQo3/bedsi7Ry5cLscjpH3UcM/caALz
         NqIHMqzfT2NT2XO/lJ8ZD4at9Q8djxwjJ7mceUU1ksNeqvDYu45jdxYbZK6Wt5P94Fmz
         xe1g==
X-Forwarded-Encrypted: i=1; AKwUvBzeQDEoGJBSjvZ5Nhy7BJ/lKuZx/vjOiVyNI8Pe1CSKqLuVPmRVsZb2N4GqmVwqmFp8S1esHBhZhDo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIz+sGeL6eVnXsSzfrnAmIvdB7TZ25Tvf+tNGYaidr0QrhNrEFi
	ETFTZ+HfzWam9/M2w6kRhhPmpW0xH1XL4ISutr3RyCwH1pg8ArUDn+LeztOMHzFy9XgsOkEeQR1
	0/f3XJLG+U7D/JiUpPPmFgO8a0lowoAji1sqdE23DYXaoLFYvYJvobCXBeOyYbQ==
X-Gm-Gg: AYBFou0wInccD7kT/538rZgUJnX7kxIsSvakaj9iVulWbCcOj/UgKgyJqv9VcSK69Bq
	Q/pb5Y9x+IswB5KKFeGjg6qzeSYVABbR/5pS0i7VKKwkVwSFqPNVBoCHLwIYS0gCGggunxzjZ4g
	LQscLaEVDFhA2RsXPjVp+NbQ4DSeywhSAzN+f0q3mU1FUR4g5/uOILkT62B7gMyQ22e5mLiAvyR
	vNAoAGOMa0TosPf8S/P+nIEJ7Q+ZZhgwC/eiE2KeOsqJQl/E8c5iE7CgrAuv+fR+EnpreVRxoM0
	IoSFOKHY7N+4KxrpdwNJDavnc8jLnzeWUOd76+uBDD1cJbXf1Wrom4R+omKBl8EGzxGq2fe5/oq
	qpeHdeg==
X-Received: by 2002:a05:600c:6095:b0:4a1:f688:a5d5 with SMTP id 5b1f17b1804b1-4a1f688a607mr49127075e9.23.1792514007496;
        Tue, 20 Oct 2026 09:33:27 -0700 (PDT)
X-Received: by 2002:a05:600c:6095:b0:4a1:f688:a5d5 with SMTP id 5b1f17b1804b1-4a1f688a607mr49126715e9.23.1792514007072;
        Tue, 20 Oct 2026 09:33:27 -0700 (PDT)
Received: from storniolo-redhat ([130.25.253.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fc0aef8fsm867165e9.0.2026.10.20.09.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:33:26 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:33:24 +0200
From: Filippo Storniolo <fstornio@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, sashiko-reviews@lists.linux.dev, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH can-next v3 3/3] can: add can diag interface
Message-ID: <ateWxIr8FNtNqWt1@storniolo-redhat>
References: <20260904-feat-can-diag-v3-0-bdcebf07b373@redhat.com>
 <20260904-feat-can-diag-v3-3-bdcebf07b373@redhat.com>
 <20260904142606.6FB371F00A3D@smtp.kernel.org>
 <atJHPuFD8dZyoDaj@storniolo-redhat>
 <20261017-delectable-mackerel-of-calibration-1fad6d-mkl@pengutronix.de>
 <20261019134500.58a76643@kernel.org>
 <20261020-reliable-loris-of-typhoon-255038-mkl@pengutronix.de>
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
In-Reply-To: <20261020-reliable-loris-of-typhoon-255038-mkl@pengutronix.de>

On Tue, Oct 20, 2026 at 02:27:25PM +0200, Marc Kleine-Budde wrote:
>On 19.10.2026 13:45:00, Jakub Kicinski wrote:
>>
>> Sort of up to you, TBH. The AI loves to point this out,
>> but I think the fact most Netlink families don't handle
>> the inconsistency for 20 years almost proves that we're
>> fine without it?
>
>Ok, I think we accept these, too. Filippo, can you update the patch
>description with this information to make the bots happy.
>
>pw-bot: cr
>
>Can you fold in this patch that adds context-analysis (and removes not
>needed "depends on CAN"). Compile with >= clang-23, see
>Documentation/dev-tools/context-analysis.rst for details.
>
>Also pleae adjust the subject to always start with "can:".
>
>regards,
>Marc
>

Hi, thank you both for the feedback.

I'll soon send the v4 with the changes you suggested here and in the other
threads.

Best regards,
Filippo

