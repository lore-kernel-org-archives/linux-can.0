Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022721;
	b=0/RMEJuTRLBxFQrHwpGnozwavKeViDEMiZcmkdfDHB/kRwz1il3VPGbL0h2NDQw96eZJ
	 csiLMWaNJH5dbcbaU5BRb7T9/xnin7Z2bvaraCjsD61TgjOH0dXktBTGuIYBUDhpwESIN
	 enRGvmyFf0Lt6Bhy8psebVCrbcwELdSbWetMQ+PazFZjOQIXY69gOI1T51gkDCsrD8+N6
	 9JCLUUy+G4WPSh7g8WPHpO1NZ/C3jn3LnShaDjHp2ZCJik0XNCdFDZazMSNZcQoYKIpJ6
	 GkaBCnA+MDcK2POQ114o9zS+cBvA3AUH2ogKDLqaR0ooqgHgvGfPp3yjDy++ZFRVuiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022721;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=yToqbndOEx+Hojl0phQ5607aWIXV5FC09eyMH7kbcws=;
	b=1zKf+eTXGPRkYTFYiJWUa42ajDOHJv/gSwWA7M/MJOqxPlrDXcVii8wHOxlsrfpZIJQO
	 CWPSJNLXaiQ/6nyLRSm1wBpKIKbR9EbUifRFg0k7tbF3i1CHqnaoDhhMrE0m4YPrfcW94
	 2kyl/IFDC9U1skjCGp/jg5XPEjYwkQ1qWMKmf3wMI7f7C6c40WQPsIEpAcKXt/lXlgTZx
	 K2cinhGE9WOcMgFgXL710BGqs3xMRM9U2vsAJCwcDZ52FoCaA2JgcZTead41dpd/K7cVR
	 9a/KFbhV+I/eL6LVGBUaaq607maVC2QEfxZ4Pjok4flpjwgmnvZ23sdsIDncceANzuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KHj81qdS;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87353606A31E
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 13:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87353606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KHj81qdS
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so19575375e9.2
        for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793022720; x=1793627520; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yToqbndOEx+Hojl0phQ5607aWIXV5FC09eyMH7kbcws=;
        b=KHj81qdSIlSFOiHthO0dlwcj+NjDovUfLvD+44dcsjtzW9O2+W/Et/Ud/nJM8FaFpj
         l7KwuQx93TM46UEIXphcndJz6PGzO1QMz0ZWcBeLzCbXS+g5roTPwf7kgEC+3Q5oOB68
         3Dk3RZ9Zs1X75896jcm/nD5wSw5PNfukwenR9dtUSofQmM8SF+t7XgBCkkG9t1Pf6ilm
         sseShP3+l7j4e/bmgZrTqzcCs7V1ZWqHAw4CFOBFe2UX1cYVHGJj5P/TV3pcnffTEDfR
         QlYsZk4vvrK+5ATPuRa/uXIJPRXb2qdmvQPOpkXH4wCk1zYjAlaJOOiZYgQKCJn3+gSb
         oHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793022720; x=1793627520;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yToqbndOEx+Hojl0phQ5607aWIXV5FC09eyMH7kbcws=;
        b=ZFAShc6jlAO63/SwpyByt9kjd1Olq1wzxvQuCd+HefU12gC/wvX9EuiuAlxot6O83z
         KqOh8B9c9F5yX/UNqlN7nCmbuDKI9ahLveDtwbikySiAQRZKfNJ2UAx9xcOBLPTOOE15
         k3G6sRAqD6d5VSES5+4IGxeJFmI/5JrqSunDSlSV3j2UIMhMVr8eIvfajMuc/xve+f33
         mtzR1TJN4ifY0rv9C8iWpYqU9FZF8zFNpVUKwSDkwmLq8Z3CvW0ABSrLwLTP7yHlUzIs
         oVs0i/fT4oF0CgK6BBRR+CyBYMA2LCOOQJz/lRtPNA5ZEZe/3rfHnurFNSxRxTbcHkBR
         FwBg==
X-Gm-Message-State: AFq9FYJk2YIOx6prdpRjRmv4jn1z/zkMYH7C/Dn2XLfMNBknvTRY73AS
	23qshkslFSC3OgcsdYWgtV/gTXhfeL/H2UaJFHijNWLU4hIkNZ2W/h9p/IhGuD4=
X-Gm-Gg: AYBFou0kfB54oQ9/I11rqv2PjFnPLneNaHk9KbxipQWvEQPTeLG1M5RYUPldoV68r/p
	7Tj+FuAWUdm/JmZsx0dy5Hw+ItVszXp6RQPj4WKYGSEGg66QqJXMvNnwKkIT7Q/1fKyH8UQJpJ3
	FOowIuVPJ0dlH6ZkuSmVivo5QTQ96axPzQDWjumoFQxchUxtlQ9PEujeG18q9ksZPIFsg7q3XtZ
	6kjhXePj3o5ELkRM+/arORzENYOM41VaWrVsJE7qF8NUMPLYwQUsNDIUkXNYxDxQAjygdDc+8aR
	exfh6VmMXeU/z8fydo9qvBd3Ze+xSVBVaqEXevEmQx5rrHim81YvXyiOzgt5QPlSfC8XiYnEth9
	34v5Mv3wMt/DeCo08lFojGMDTfourGYRjTR9c0WhVg838py1rFBxZg4US5EXX5UK+cIkpn55N//
	PWz1pRN5XRT4A50+TveJ3HEeIwk71XNR+O7vniJJWr05aWXhccV/v/5WseN3W1BU8bBNdPMU+BP
	ORTKuubRPsmfYVFkeCUheJYfBZqW7kYUKQ=
X-Received: by 2002:a05:600c:a318:b0:4a3:5aee:2c25 with SMTP id 5b1f17b1804b1-4a35aee2cfdmr94233795e9.31.1793022719649;
        Mon, 26 Oct 2026 06:51:59 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a574088sm182895725e9.9.2026.10.26.06.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 06:51:58 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: netdev-bot+sinfo@kernel.org
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, mkl@pengutronix.de,
 socketcan@hartkopp.net, s.grosjean@peak-system.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 net] can: peak_usb: fix use-after-free on PCAN-USB
 disconnect and init failure
Date: Mon, 26 Oct 2026 13:51:56 -0000
Message-ID: <179302271698.3957649.179210854484018832@talencesecurity.com>
In-Reply-To: <179296234587.3327.17827320411071304419@kernel.org>
References: <20261025210256.629830-1-tristan@talencesecurity.com>
 <179296234587.3327.17827320411071304419@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

The issue was found by manual code inspection of USB CAN driver
disconnect and error handling paths, specifically looking for missing
timer/work cancellation before device structure teardown.

The bug has not been triggered in practice.  The race window is between
a bus error arming restart_timer in pcan_usb_restart_async() and a
concurrent USB disconnect calling peak_usb_disconnect() which frees the
candev.  The PCAN-USB adapter does not register a dev_free callback, so
the timer is never cancelled on the disconnect path.
