document.addEventListener('DOMContentLoaded', function() {
    // Form input animations
    const inputs = document.querySelectorAll('.form-group input');
    
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentNode.querySelector('i').style.color = '#667eea';
        });
        
        input.addEventListener('blur', function() {
            this.parentNode.querySelector('i').style.color = '#999';
        });
    });
    
    // Button hover effect
    const authButton = document.querySelector('.btn-auth');
    if (authButton) {
        authButton.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
            this.style.boxShadow = '0 7px 14px rgba(50,50,93,.1), 0 3px 6px rgba(0,0,0,.08)';
        });
        
        authButton.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = 'none';
        });
    }
    
    // Form submission loading state
    const forms = document.querySelectorAll('.auth-form-content');
    forms.forEach(form => {
        form.addEventListener('submit', function() {
            const button = this.querySelector('button[type="submit"]');
            if (button) {
                button.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
                button.disabled = true;
            }
        });
    });
});