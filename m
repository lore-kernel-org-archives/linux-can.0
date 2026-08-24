Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA40E380FDD
	for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787614849; cv=none; b=L0Ltc78h6bSkLA1R7tsRcS6v2Eji0Q/Inja1E99zcdKdJ9gzVl2Wt+D93f4TZBAaPDRJ/btxYjf2Zo+E99/hKytizcsfW0ENims73vv5lbupxORT0nP/FA9cAPPCU6dfeX/Q92CaDaer/hqZLt8BcHTNt5Zp/Ji9MVcIjfRk5dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787614849; c=relaxed/simple;
	bh=UK3Ka/ym/G0XcukOVsVyV6NnJWs41Sf1ZVaK1C/8CzU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ejv2auHBZvFKK8/tIXm0ZDmGRiyNLveXG0OMihsrStYTYcNF39JfqTPAOTX8s/Pr94nVIuoKohoje/OnQH027LxHmSKv1AQRQDLCnHQW1T6Nm+BM0CFfrgcdR2MAspt0LueoPflzbM/a8n2mXWRjBAQdl+KP3EFuuO51r1qTI+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dwilley.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qLGIWIhQ; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dwilley.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qLGIWIhQ"
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e9e2db9914so452039a34.1
        for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 16:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787614847; x=1788219647; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UK3Ka/ym/G0XcukOVsVyV6NnJWs41Sf1ZVaK1C/8CzU=;
        b=qLGIWIhQff+Zn6beqaYsDHrA1QjQSF5xKH6RVedIxK8BifC/WqAW13xuHTO0qvV09b
         CrTOxiqyS6rbno2Pqz2AboT0sFNtPkQ7XAvpNWtqrY9NKx7/QRCdhn9zuTODOK+/vm6c
         6fONEzDTBYuBdMTV3oMskaXXjPg8eeoWxZ29Y4VApmH0DadZvxvOEuUIb5ovLipuYTh0
         wYbAeJ7PawH+jNcR6dZDtou9XLRLQC0iQO8O8IqvxxbMFEe/EW84IfQ/SToDHeSDlYQH
         IOUj7i8MqmDcHr7s/9LE3koGm4LIJdtLSleztDXf3IlLXcjFcZWZpdFcBIuOUlKvVx40
         f+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787614847; x=1788219647;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UK3Ka/ym/G0XcukOVsVyV6NnJWs41Sf1ZVaK1C/8CzU=;
        b=U2yZMNGPhE0CGVGxNYxtOj+jEo8Ln96cFyaXSHjprvZYYXT4D6Ez+acwfRMBofn7Ee
         KgXDZ9OWDqhihsdkhz99LorOx3oiq9R2dMMe/9x5rAE1W7LEuW5fWEGtLLcMZrRBBRLt
         1MHw6a//X0u7Q0u6LZVdypg5pwm+xq/XryrZ1UT7PbO423MfgwKBlqp6JVgtKEfAmqvr
         b/qE4u5piYrNH3s2YWupuTlmS1hXhVhYFrwX9JBqza5HwlJRVwJoKnt1560fUBLxsY0L
         +z1wfvm+cY/pfzxudD5VZIyniRXOhGEwWjdFh+x85Paxyr9uAnMcShbTjYdFQAs9TA1w
         GZ3w==
X-Forwarded-Encrypted: i=1; AHgh+Rop+pe6d3pYoYeN3AEVZRkyfjWhYdL7qyQsm0iE7bmO+dHTN+p6vrUIn3nPlREBgXqfF0rgW0U6cYE=@vger.kernel.org
X-Gm-Message-State: AFuF++k00SHT+Ehup1SDqIsdr2YjSMCCXW6L+X/ArkK+3MRsAdwqIg0l
	zFWMbV+AKV5PwGL3LJCATz5RSK79o/5mOuotI0Aq94Nnq1padLRHYRSkLGqLed9GzTkAhpR3VGr
	Qj9NvGvsP7Q==
X-Received: from iobip13.prod.google.com ([2002:a05:6602:6e0d:b0:9ab:3339:3966])
 (user=dwilley job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:1908:b0:6a3:6f5d:4d6c
 with SMTP id 006d021491bc7-6b18faa5cadmr2046337eaf.6.1787614846566; Mon, 24
 Aug 2026 16:40:46 -0700 (PDT)
Date: Mon, 24 Aug 2026 23:39:52 +0000
In-Reply-To: <20260824-alluring-affable-hog-d072e8-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260824-alluring-affable-hog-d072e8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260824233953.2057979-1-dwilley@google.com>
Subject: Re: [PATCH v2] can: usb: f81604: fix struct f81604_int_data size mismatch
From: Drew Willey <dwilley@google.com>
To: mkl@pengutronix.de
Cc: admin@dynetrex.com, devnull+peter_hong.fintek.com.tw@kernel.org, 
	gregkh@linuxfoundation.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol@kernel.org, peter_hong@fintek.com.tw, 
	stable@vger.kernel.org, Drew Willey <dwilley@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested running ChromeOS, kernel 6.12, rev facaadd, f81604=C2=A0(2c42:1709),=
 the driver hits "f81604_read_int_callback: short int URB: 9 < 12"=C2=A0on =
the first Tx attempt and stops the Tx queue. Subsequent frames queue up and=
 are not transmitted.

Reloaded the f81604 module with this patch. Transmitted several frames over=
 a minute and all succeed.

Tested-by: Drew Willey <dwilley@google.com>
