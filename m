Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BB3548561
	for <linux-can@vger.kernel.org>; Thu, 17 Sep 2026 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652471; cv=none; b=koFpRlWhtg6lC4f+abOBo6WM74zDP0eszW4F967wzDqaQmVJ/o8muQ8yFWRXzrbFuu1tuEvmy9odymm5oj7LpRK3Usquo4NMMBZfMgOlRrHRuNFC62zMx/bVrTLIhXtgva7bW+P/gEo4vDHs6JP8HGm9QoPBMyWClM45E7Dsva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652471; c=relaxed/simple;
	bh=KOaJCWghMntV5TzVNT+bkin6AYRjjP3DTNMu6mqyk6M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZUBO4zC1HI9SAdT/eSYvVGig/1owutwzWSJvZnWxLgOVAZ9ejHNhR+LaMvjL1464h3fPH/9FneBypT2oKf2y+M4gmg+Kw/PjWMxVZYcqS/Uf5RZk6d/hPbmA3GEvduF9Gp3y6b6JgstsZSm6mizC0jAgypWhgQxw1c5CHWTjWDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conchuod.ie; spf=pass smtp.mailfrom=conchuod.ie; dkim=pass (2048-bit key) header.d=conchuod.ie header.i=@conchuod.ie header.b=KnuSX4Y3; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conchuod.ie
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conchuod.ie
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conchuod.ie header.i=@conchuod.ie header.b="KnuSX4Y3"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a996c8adf3so1432476a12.1
        for <linux-can@vger.kernel.org>; Thu, 17 Sep 2026 06:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conchuod.ie; s=google; t=1789652466; x=1790257266; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dABE6Xxrz13aNXEetLj7J15+q28FsJ34U3AEi9ktr74=;
        b=KnuSX4Y3izRMU9XZbk1a7n7t+9Yx74uGbWU1IDRq+01FK3ay81PzZ/5pG9m9g67mbO
         zdmqfaDudJTYsb5hLOjR+f04pcjvbeDuTkB3FlVe1ApQh5qzKQ+8A377y+gbVewcPy9X
         sH+1R28O2/d+btx5vu3F3+0XafusB2g9sFsrb371w44K3LjVI/FGZPs6tJK/F2ziTK/U
         YC24QQ6ST+vVLrM+zgzfMp3YveaQj3I70UOJfox3doXwRO0wk3bP5z3qRJOAyRhOfXGI
         F2NOYEoLqxb2ejnAcP4bEh2FakLC+qvArzf+DCIzSer2rdQP9SYog/OS0jBCxQALdbd9
         K4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789652466; x=1790257266;
        h=content-transfer-encoding:content-type:mime-version:message-id
         :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dABE6Xxrz13aNXEetLj7J15+q28FsJ34U3AEi9ktr74=;
        b=ivXId3AiQW7hD+1TaBsg+7YUe9712YIr7YLeJ8obNjjYPY2iTfUZepNz65EQa6hOL3
         ftGqt9rAqzcTYIecJxEn9H62p/vNq2edk9Jt65QVNbnMYKlFkTEtk7hOxzfecBCE7cAu
         CCAm+n4p2JE/ezwma6zbQtyWmNgEJAmXoYMeAEjdtI7C19LX57jDDvwQjO817dm33Clv
         itYDEdaVI5CsxpuZBK/S2q4N6A8+rJtzdOTNs7Vq2uhNzL4+inGNLOT8rNLhyPHUVIvJ
         EwCT7CSPlS4Em2KqHi7ejSmCGjSpV3AC7JkUSWHyBnVBcz1yqKjHpVWZgNqmMIIcgGYP
         5jUQ==
X-Forwarded-Encrypted: i=1; AKwUvBzBL8eNgC6IP5KiK2HqacLJGsKrG8o780b0w1he/t+9DQBs3j1IS3jfkm7kX3WT23f0PZPuNcDftkM=@vger.kernel.org
X-Gm-Message-State: AFuF++nGf8vrii1QjjS52aJQabwq48/2Rwyx1/Ri3ujKi0idhuti76lQ
	Yj/SbSy4VjgkILpKLcJ48HIi9CLVi3hrOH33kBjdRq9J5FHxGdGXTou1iB+VzlGl+37JF7SSC1l
	2M9pnS3g=
X-Gm-Gg: AYBFou24g4L0pZA9SGytmP6/ycMn8GfwSEo5BS5lkbM9ece5sD5lZvSMT6ahtp4Mcr4
	04bTt1tBLq3GiOBUuAyJxHJuzJTFrpb0Bs93daCdcMNuHzsEcbtlb/JkI1MdtQk0fHwAwSDSVcx
	5idxuPBjbva6oi9QS5PtGmZWcyesnQRMxXT0+/mWpUI+/ZxIn+Y6Y/EmlIjlMKYY07+hkVjylkb
	+SxZ4ikAW/YzbkMzG/JqhZ3EBIwR0t+fGAxWZiyODUoBpg4uuFgBIhEVbfFE9qI1kr58vfLAGHO
	6sZJiOUXXXZFiphOEEeohyXPiPmEaW2FQtxNbHfdCpGw8Cr+VH8gcWhC07xJ5Hsb5+pa1evQZc7
	WP36fqkcLE0RMTo8tM693O2hQL1x3qOhyMyH19W33R/BnFQUaBkeOKAI0TeYmlk9NVOloXqri5Y
	hDIVZZEvUf6yHmHqP03ahPwLqnS0cfZrBYrasl7lPXKknNFzULmXHfCvKep277cS4NOAtfk10=
X-Received: by 2002:a17:907:d92:b0:c29:f5d8:9c70 with SMTP id a640c23a62f3a-c29f5d89d21mr233167566b.31.1789652465825;
        Thu, 17 Sep 2026 06:41:05 -0700 (PDT)
Received: from ehlo.thunderbird.net ([77.20.9.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de48750fsm298989866b.31.2026.09.17.06.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 06:41:04 -0700 (PDT)
Date: Thu, 17 Sep 2026 15:41:01 +0200
From: Conor <mail@conchuod.ie>
To: Quchaosheng <quchaosheng000406@163.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
CC: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-can@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5] dt-bindings: net: can: convert ifi_canfd to DT schema
User-Agent: K-9 Mail for Android
In-Reply-To: <20260917092046.388076-1-quchaosheng000406@163.com>
References: <20260914022145.408976-1-quchaosheng000406@163.com> <70ae05a5-2415-4895-bc64-37b3d3ba54ac@kernel.org> <20260917092046.388076-1-quchaosheng000406@163.com>
Message-ID: <98F28A31-2DAD-45CA-9261-C77E5C10806F@conchuod.ie>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 17 September 2026 11:20:46 GMT+02:00, Quchaosheng <quchaosheng000406@16=
3=2Ecom> wrote:
>Hi Krzysztof,
>
>You are right, and sorry for the noise=2E I have stopped sending=2E Nothi=
ng is
>queued, and I will not repost the three CAN bindings unless you ask me to=
=2E
>
>What I got wrong, and what is fixed before anything goes out again:
>
>1=2E Threading=2E I attached new versions to older threads and unrelated
>   patchsets=2E That is exactly what submitting-patches=2Erst warns about=
: it
>   buried the patches and made Patchwork show several versions of one fil=
e=2E
>   The next posting is one series, in its own thread, one version only=2E
>
>2=2E spi-peripheral-props=2E Dropped, as you asked=2E The binding now ref=
erences
>   only can-controller=2Eyaml, and dt_binding_check passes=2E
>
>3=2E clock-frequency=2E Dropped, and clocks stays required=2E You were ri=
ght that
>   it is ACPI-only; I had argued from the driver code instead of reading =
the
>   git history=2E
>
>4=2E Commit messages rewritten as short declarative sentences that descri=
be
>   only what changed in the binding=2E
>
>5=2E One thing I should have said from the start: these patches were prep=
ared
>   with an LLM coding assistant=2E Per
>   Documentation/process/coding-assistants=2Erst they need an
>   "Assisted-by: LLM" tag, and mine did not carry one=2E It is now on eve=
ry
>   patch=2E You told me not to paste LLM text, and I should also have

And yet, this looks exactly like LLM pasted text=2E
That's an insult to all who genuinely engage with the development process,=
 who knows if you even understand what's been said here, and are just blind=
ly pasting back and forth=2E
If we wanted to have a discussion with an LLM, we can do that ourselves=2E=
 We don't need you in the loop for that=2E

Thanks,
Conor=2E

>   disclosed that the text was LLM-assisted=2E Not doing that was the wor=
st
>   part of this, not the wording=2E
>
>The bindings are otherwise unchanged=2E holt, mpc5xxx-mscan and ifi,canfd=
 are
>ready as a single clean v7 series=2E Tell me when you want it and I will =
post
>it in one new thread=2E
>
>Thanks for the pointers=2E
>
>Quchaosheng
>
